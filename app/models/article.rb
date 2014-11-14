# encoding: UTF-8
class Article < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::AsyncCallbacks

  include Classifiable

  attr_accessible :content
  attr_accessible :source_url
  # Tags
  acts_as_taggable
  attr_accessible :tag_list
  acts_as_taggable_on :targets, :actions
  attr_accessible :target_list, :action_list

  index_name "#{Tire::Model::Search.index_prefix}articles"
  refresh = -> { Tire::Index.new(index_name).refresh }
  after_save(&refresh)
  after_destroy(&refresh)

  validates :content, presence: true

  settings analysis: {
    analyzer: {
      search_analyzer: {
        type: 'custom',
        tokenizer: 'standard',
        filter: %w(lowercase snowball asciifolding)
      },
      ngramer: {
        type: 'custom',
        tokenizer: 'standard',
        filter: %w(lowercase snowball substring)
      }
    },
    filter: {
      substring: {
        type: 'nGram',
        min_gram: 1,
        max_gram: 40,
        token_chars: %w(letter digit)
      }
    }
  } do
    mapping do

      indexes :id, index: :not_analyzed
      indexes :site do
        indexes :id        , type: 'integer'
        indexes :name      , type: 'string', index: :not_analyzed
        indexes :ngram_name, index_analyzer: 'ngramer', search_analyzer: 'snowball'
      end

      indexes :title, type: 'multi_field', fields: {
        title: {
          type: 'string',
          index_analyzer: 'ngramer',
          search_analyzer: 'snowball'
        },
        exact: { type: 'string', index: :not_analyzed, boost: 50 }
      }
      indexes :english_title, type: 'multi_field', fields: {
        english_title: {
          type: 'string',
          index_analyzer: 'ngramer',
          search_analyzer: 'snowball'
        },
        exact: { type: 'string', index: :not_analyzed }
      }

      indexes :authors do
        indexes :name, type: 'string', index: :not_analyzed
      end

      indexes :content, type: 'multi_field', fields: {
        content: {
          type: 'string',
          index_analyzer: 'ngramer',
          search_analyzer: 'snowball'
        },
        exact: { type: 'string', index: :not_analyzed }
      }

      indexes :source_url,
              type: 'string',
              index_analyzer: 'ngramer' ,
              search_analyzer: 'search_analyzer'

      indexes :languages do
        indexes :id , type: 'integer'
        indexes :name , type: 'string' , index: :not_analyzed
        indexes :ngram_name ,
                index_analyzer: 'ngramer' ,
                search_analyzer: 'snowball'
      end

      indexes :countries do
        indexes :id, type: 'integer'
        indexes :name, type: 'string' , index: :not_analyzed
        indexes :ngram_name ,
                index_analyzer: 'ngramer' ,
                search_analyzer: 'snowball'
      end

      indexes :tags do
        indexes :name, type: 'multi_field', fields: {
          name:  { type: 'string', index_analyzer: 'ngramer',
                   search_analyzer: 'snowball' },
          exact: { type: 'string', index: :not_analyzed }
        }
      end

      indexes :targets do
        indexes :title, type: 'multi_field', fields: {
          title: {
            type: 'string',
            index_analyzer: 'ngramer',
            search_analyzer: 'snowball'
          },
          exact: { type: 'string', index: :not_analyzed }
        }
      end

      indexes :biographical_region, type: 'string', index: :not_analyzed
      indexes :published_on       , type: 'date', index: :not_analyzed

      indexes :approved           , type: 'boolean'
      indexes :approved_at        , type: 'date'
      indexes :created_at         , type: 'date'
    end
  end

  def to_indexed_json
    {
      site: {
        _type: 'site',
        _id: site.id,
        name: site.name,
        ngram_name: site.name
      },
      title:          title,
      english_title:  english_title,
      content:        content_without_tags,
      source_url:     source_url,
      authors:        splitted_authors.map { |a| { name: a } },
      published_on:   published_on,

      approved:       approved,
      approved_at:    approved_at,
      created_at:     created_at,

      languages:      languages.map do |l|
        { _type: 'language', _id: l.id, name: l.name, ngram_name: l.name }
      end,
      countries:      countries.map do |c|
        { _type: 'country', _id: c.id, name: c.name, ngram_name: c.name }
      end,

      tags:           tag_list.map { |t| { name: t } },
      targets:        target_list.map { |t| { title: t.split(':')[0] }},
      biographical_region: biographical_region.blank? ? nil : biographical_region
    }.to_json
  end

  def content_without_tags
    self.content.gsub(/<\/?[^>]*>/, "")
  end

  def self.search(params)

    params[:query].gsub!(/[\+\-\:\"\~\*\!\?\{\}\[\]\(\)]/, '\\1') if params[:query].present?
    show_approved = (params[:approved].present? && params[:approved] == 'true') ? true : false

    date_init, date_end = nil
    if params[:published_on].present?
      date_init = DateTime.new(params[:published_on].to_i, 1, 1)
      date_end = DateTime.new(params[:published_on].to_i, 12, 31)
    end

    # Facet Filter
    art_filter = []
    art_filter << { term: { 'site.name' => params[:site] }}                            if params[:site].present?
    art_filter << { term: { 'authors.name' => params[:author] }}                                 if params[:author].present?
    art_filter << { term: { 'countries.name' => params[:countries].split(/\//) }}      if params[:countries].present?
    art_filter << { term: { 'languages.name' => params[:languages].split(/\//) }}      if params[:languages].present?
    art_filter << { term: { biographical_region: params[:biographical_region] }}       if params[:biographical_region].present?
    art_filter << { range:{ published_on: { gte: date_init , lt: date_end }}}          if params[:published_on].present?
    art_filter << { bool: { must: { term: { approved: show_approved} }}}

    tire.search load: true, page: params[:page], per_page: params[:per_page] do
      query do
        boolean do
          should { string 'site.ngram_name:'      + params[:query].to_s }
          should { string 'title:'                + params[:query].to_s }
          should { string 'title.exact:'          + params[:query].to_s }
          should { string 'english_title:'        + params[:query].to_s }
          should { string 'english_title.exact:'  + params[:query].to_s }
          should { string 'description:'          + params[:query].to_s }
          should { string 'ngram_author:'         + params[:query].to_s }
          should { string 'attachment:'           + params[:query].to_s }
          should { string 'countries.ngram_name:' + params[:query].to_s }
          should { string 'languages.ngram_name:' + params[:query].to_s }
          should { string 'tags.ngram_name:'      + params[:query].to_s }
          should { string 'biographical_region:'  + params[:query].to_s }
          should { string 'content:'              + params[:query].to_s }
        end
      end if params[:query].present?

      highlight :title, :content

      filter :term, 'site.name' => params[:site] if params[:site].present?
      filter :term, source_db: params[:source_db] if params[:source_db].present?
      filter :term, 'authors.name' =>  params[:author] if params[:author].present?
      filter :term, 'countries.name' => params[:countries].split(/\//) if params[:countries].present?
      filter :term, 'languages.name' => params[:languages].split(/\//) if params[:languages].present?
      # filter :term, geographical_coverage: params[:geographical_coverage] if params[:geographical_coverage].present?
      filter :term, biographical_region: params[:biographical_region] if params[:biographical_region].present?
      filter :range, published_on: { gte: date_init , lt: date_end } if params[:published_on].present?

      filter :bool, must: { term: { approved: show_approved } }

      if params[:sort].present?
        sort { by params[:sort].to_sym, params[:sort] == "published_on" ? "desc" : "asc" }
      else
        # if no query, sort by published_on
        sort { by :published_on, "desc" } unless params[:query].present?
      end

      facet 'sites' do
        terms 'site.name'
        facet_filter :and, art_filter unless art_filter.empty?
      end

      facet 'authors' do
        terms 'authors.name'
        facet_filter :and, art_filter unless art_filter.empty?
      end

      facet 'countries' do
        terms 'countries.name', size: 60
        facet_filter :and, art_filter unless art_filter.empty?
      end

      facet 'biographical_regions' do
        terms :biographical_region # , script_field: true, size: 50
        facet_filter :and, art_filter unless art_filter.empty?
      end

      facet 'languages' do
        terms 'languages.name'
        facet_filter :and, art_filter unless art_filter.empty?
      end

      facet('timeline') do
        date :published_on, interval: 'year'
        facet_filter :and, art_filter unless art_filter.empty?
      end

      # facet('target') do
      #   terms 'targets.title'
      #   facet_filter :and, art_filter unless art_filter.empty?
      # end
    end
  end

end