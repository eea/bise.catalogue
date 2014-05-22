class Link < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  include Classifiable

  attr_accessible :url
  attr_accessible :description

  # TAGS
  acts_as_taggable
  attr_accessible :tag_list
  acts_as_taggable_on :targets, :actions
  attr_accessible :target_list, :action_list

  validates :url, presence: true, uniqueness: true
  # validates_format_of :url, with: /^(((http|https):\/\/))[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix

  index_name "#{Tire::Model::Search.index_prefix}links"

  refresh = lambda { Tire::Index.new(index_name).refresh }
  after_save(&refresh)
  after_destroy(&refresh)

  settings analysis: {
    analyzer: {
      search_analyzer: {
        tokenizer: 'keyword',
        filter: %w(lowercase snowball)
      },
      index_ngram_analyzer: {
        type: 'custom',
        tokenizer: 'standard',
        filter: %w(lowercase snowball substring)
      }
    },
    filter: {
      substring: {
        type: 'nGram',
        min_gram: 1,
        max_gram: 20,
        token_chars: %(letter digit)
      }
    }
  } do
    mapping {

      indexes :site do
        indexes :id,
                type: 'integer'
        indexes :name,
                type: 'string',
                index: :not_analyzed
        indexes :ngram_name,
                index_analyzer: 'index_ngram_analyzer' ,
                search_analyzer: 'snowball'
      end

      indexes :id, index: :not_analyzed
      indexes :title, type: 'multi_field', fields: {
        title: {
          type: 'string',
          index_analyzer: 'index_ngram_analyzer',
          search_analyzer: 'snowball'
        },
        exact: { type: 'string', index: :not_analyzed }
      }
      indexes :english_title, type: 'multi_field', fields: {
        english_title: {
          type: 'string',
          index_analyzer: 'index_ngram_analyzer',
          search_analyzer: 'snowball'
        },
        exact: { type: 'string', index: :not_analyzed }
      }

      indexes :url,
              type: 'string',
              index_analyzer: 'index_ngram_analyzer' ,
              search_analyzer: 'search_analyzer'

      indexes :description,
              type: 'string',
              index_analyzer: 'index_ngram_analyzer' ,
              search_analyzer: 'snowball'

      indexes :languages do
        indexes :id,
                type: 'integer'
        indexes :name,
                type: 'string',
                index: :not_analyzed
        indexes :ngram_name ,
                index_analyzer: 'index_ngram_analyzer' ,
                search_analyzer: 'snowball'
      end

      indexes :countries do
        indexes :id,
                type: 'integer'
        indexes :name,
                type: 'string',
                index: :not_analyzed
        indexes :ngram_name,
                index_analyzer: 'index_ngram_analyzer',
                search_analyzer: 'snowball'
      end

      indexes :tags do
        indexes :name,
                type: 'string' ,
                index: :not_analyzed
        indexes :ngram_name ,
                index_analyzer: 'index_ngram_analyzer' ,
                search_analyzer: 'snowball'
      end

      indexes :targets do
        indexes :title,
                type: 'string' ,
                index: :not_analyzed
        indexes :ngram_title ,
                index_analyzer: 'index_ngram_analyzer' ,
                search_analyzer: 'snowball'
      end

      indexes :biographical_region,
              type: 'string',
              index: :not_analyzed
      indexes :author,
              type: 'string',
              index: :not_analyzed
      indexes :published_on,
              type: 'date'

      indexes :approved           , type: 'boolean'
      indexes :approved_at        , type: 'date'
      indexes :created_at         , type: 'date'
    }
  end

  def to_indexed_json
    {
      site:           {
        _type: 'site',
        _id: site.id,
        name: site.name,
        ngram_name: site.name
      },
      title:        title,
      english_title:english_title,

      url:          url,
      description:  description,

      author:       author,
      ngram_author: author,
      published_on: published_on,

      approved:     approved,
      approved_at:  approved_at,
      created_at:   created_at,

      languages: languages.map do |l|
        { _type: 'language', _id: l.id, name: l.name, ngram_name: l.name }
      end,
      countries:      countries.map do |c|
        { _type: 'country', _id: c.id, name: c.name, ngram_name: c.name }
      end,

      tags: tags.map do |t|
        { name: t.name, ngram_name: t.name }
      end,
      targets: targets.map do |t|
        { title: t.name.split(':')[0], ngram_title: t.name }
      end,

      biographical_region: biographical_region
    }.to_json
  end

  def self.search(params)

    params[:query].gsub!(/[\+\-\:\"\~\*\!\?\{\}\[\]\(\)]/, '\\1')                          if params[:query].present?
    show_approved = (params[:approved] && params[:approved] == 'true') ? true : false

    date_init, date_end = nil
    if params[:published_on].present?
      date_init = DateTime.new(params[:published_on].to_i, 1, 1)
      date_end = DateTime.new(params[:published_on].to_i, 12, 31)
    end

    # Facet Filter
    link_filter = []
    link_filter << { term: { 'site.name' => params[:site] }} if params[:site].present?
    link_filter << { term: { author: params[:author] }} if params[:author].present?
    link_filter << { term: { 'countries.name' => params[:countries].split(/\//) }} if params[:countries].present?
    link_filter << { term: { 'languages.name' => params[:languages].split(/\//) }} if params[:languages].present?
    link_filter << { term: { biographical_region: params[:biographical_region] }} if params[:biographical_region].present?
    link_filter << { range: { published_on: { gte: date_init , lt: date_end }}} if params[:published_on].present?
    link_filter << { bool: { must: { term: { approved: show_approved} }}}

    tire.search load: true, page: params[:page], per_page: 10 do

      query do
        boolean do
          should { string 'site.ngram_name:'           + params[:query].to_s }
          should { string 'title:'                     + params[:query].to_s }
          should { string 'title.exact:'               + params[:query].to_s }
          should { string 'english_title:'             + params[:query].to_s }
          should { string 'english_title.exact:'       + params[:query].to_s }
          should { string 'description:'               + params[:query].to_s }
          should { string 'url:'                       + params[:query].to_s }
          should { string 'ngram_author:'              + params[:query].to_s }
          should { string 'countries.ngram_name:'      + params[:query].to_s }
          should { string 'languages.ngram_name:'      + params[:query].to_s }
          should { string 'tags.ngram_name:'           + params[:query].to_s }
          should { string 'biographical_region:' + params[:query].to_s }
        end
      end if params[:query].present?

      highlight :title, :url

      filter :term, 'site.name' => params[:site] if params[:site].present?
      filter :term, source_db: params[:source_db] if params[:source_db].present?
      filter :term, author: params[:author] if params[:author].present?
      filter :term, 'countries.name' => params[:countries].split(/\//) if params[:countries].present?
      filter :term, 'languages.name' => params[:languages].split(/\//) if params[:languages].present?
      # filter :term, geographical_coverage: params[:geographical_coverage] if params[:geographical_coverage].present?
      filter :term, biographical_region: params[:biographical_region] if params[:biographical_region].present?
      filter :range, published_on: { gte: date_init , lt: date_end } if params[:published_on].present?

      filter :bool, must: { term: { approved: show_approved } }

      sort { by :published_on, "desc" } if params[:query].blank?

      facet 'sites' do
        terms 'site.name'
        facet_filter :and, link_filter unless link_filter.empty?
      end

      facet 'authors' do
        terms :author
        facet_filter :and, link_filter unless link_filter.empty?
      end

      facet 'countries' do
        terms 'countries.name', size: 60
        facet_filter :and, link_filter unless link_filter.empty?
      end

      # facet 'geographical_coverages' do
      #     terms :geographical_coverage
      # end

      facet 'biographical_regions' do
        terms :biographical_region
        facet_filter :and, link_filter unless link_filter.empty?
      end

      facet 'languages' do
        terms 'languages.name'
        facet_filter :and, link_filter unless link_filter.empty?
      end

      facet('timeline') do
        date :published_on, interval: 'year'
        facet_filter :and, link_filter unless link_filter.empty?
      end

      # facet('target') do
      #   terms 'targets.title'
      #   facet_filter :and, link_filter unless link_filter.empty?
      # end
    end
  end
end
