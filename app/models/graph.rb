class Graph < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::AsyncCallbacks

  # thumbnail
  mount_uploader :thumb, ThumbUploader
  attr_accessible :thumb
  validates :thumb, presence: { on: :create }
  # before_save :update_thumb_info
  before_destroy { |graph| graph.remove_thumb! }

  # TAGS
  acts_as_taggable
  attr_accessible :tag_list
  acts_as_taggable_on :targets, :actions
  attr_accessible :target_list, :action_list

  include Classifiable

  attr_accessible :url
  attr_accessible :description

  attr_accessible :is_part_of
  attr_accessible :is_replaced_by
  attr_accessible :has_part
  attr_accessible :thumbnail_link
  attr_accessible :embed_code

  validates :url, presence: true, uniqueness: true
  # validates_format_of :url, with: /^(((http|https):\/\/))[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix

  index_name "#{Tire::Model::Search.index_prefix}graphs"

  refresh = lambda { Tire::Index.new(index_name).refresh }
  after_save(&refresh)
  after_destroy(&refresh)

  settings analysis: {
    analyzer: {
      search_analyzer: {
        tokenizer: 'keyword',
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
        max_gram: 20,
        token_chars: %(letter digit)
      }
    }
  } do
    mapping {

      indexes :id, index: :not_analyzed
      indexes :site do
        indexes :id,
                type: 'integer'
        indexes :name,
                type: 'string',
                index: :not_analyzed
        indexes :ngram_name,
                index_analyzer: 'ngramer' ,
                search_analyzer: 'snowball'
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

      indexes :url,
              type: 'string',
              index_analyzer: 'ngramer' ,
              search_analyzer: 'search_analyzer'

      indexes :description,
              type: 'string',
              index_analyzer: 'ngramer' ,
              search_analyzer: 'snowball'

      indexes :languages do
        indexes :id,
                type: 'integer'
        indexes :name,
                type: 'string',
                index: :not_analyzed
        indexes :ngram_name ,
                index_analyzer: 'ngramer' ,
                search_analyzer: 'snowball'
      end

      indexes :countries do
        indexes :id,
                type: 'integer'
        indexes :name,
                type: 'string',
                index: :not_analyzed
        indexes :ngram_name,
                index_analyzer: 'ngramer',
                search_analyzer: 'snowball'
      end

      indexes :tags do
        indexes :name,
                type: 'string' ,
                index: :not_analyzed
        indexes :ngram_name ,
                index_analyzer: 'ngramer' ,
                search_analyzer: 'snowball'
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
      indexes :published_on, type: 'date'

      indexes :approved,    type: 'boolean'
      indexes :approved_at, type: 'date'
      indexes :created_at,  type: 'date'
      indexes :thumb,   type: 'string', index: :not_analyzed
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

      authors:      splitted_authors.map { |a| { name: a } },
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
        { title: t.name.split(':')[0] }
      end,

      thumb: thumb_url,
      biographical_region: biographical_region
    }.to_json
  end

  def self.search(params)

    params[:query].gsub!(/[\+\-\:\"\~\*\!\?\{\}\[\]\(\)\/]/, '\\1')                          if params[:query].present?
    show_approved = (params[:approved] && params[:approved] == 'true') ? true : false

    date_init, date_end = nil
    if params[:published_on].present?
      date_init = DateTime.new(params[:published_on].to_i, 1, 1)
      date_end = DateTime.new(params[:published_on].to_i, 12, 31)
    end

    # Facet Filter
    graph_filter = []
    graph_filter << { term: { 'site.name' => params[:site] }} if params[:site].present?
    graph_filter << { term: { 'authors.name' => params[:author] }} if params[:author].present?
    graph_filter << { term: { 'countries.name' => params[:countries].split(/\//) }} if params[:countries].present?
    graph_filter << { term: { 'languages.name' => params[:languages].split(/\//) }} if params[:languages].present?
    graph_filter << { term: { 'targets.title.exact' => params[:target] }} if params[:target].present?
    graph_filter << { term: { biographical_region: params[:biographical_region] }} if params[:biographical_region].present?
    graph_filter << { range: { published_on: { gte: date_init , lt: date_end }}} if params[:published_on].present?
    graph_filter << { bool: { must: { term: { approved: show_approved} }}}

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
          should { string 'authors.name:'              + params[:query].to_s }
          should { string 'countries.ngram_name:'      + params[:query].to_s }
          should { string 'languages.ngram_name:'      + params[:query].to_s }
          should { string 'tags.ngram_name:'           + params[:query].to_s }
          should { string 'biographical_region:' + params[:query].to_s }
        end
      end if params[:query].present?

      highlight :title, :url

      filter :term, 'site.name' => params[:site] if params[:site].present?
      filter :term, source_db: params[:source_db] if params[:source_db].present?
      filter :term, 'authors.name' => params[:author] if params[:author].present?
      filter :term, 'countries.name' => params[:countries].split(/\//) if params[:countries].present?
      filter :term, 'languages.name' => params[:languages].split(/\//) if params[:languages].present?
      filter :term, 'targets.title.exact' => params[:target]  if params[:target].present?
      # filter :term, geographical_coverage: params[:geographical_coverage] if params[:geographical_coverage].present?
      filter :term, biographical_region: params[:biographical_region] if params[:biographical_region].present?
      filter :range, published_on: { gte: date_init , lt: date_end } if params[:published_on].present?

      filter :bool, must: { term: { approved: show_approved } }

      sort { by :published_on, "desc" } if params[:query].blank?

      facet 'sites' do
        terms 'site.name'
        facet_filter :and, graph_filter unless graph_filter.empty?
      end

      facet 'authors' do
        terms 'authors.name'
        facet_filter :and, graph_filter unless graph_filter.empty?
      end

      facet 'countries' do
        terms 'countries.name', size: 60
        facet_filter :and, graph_filter unless graph_filter.empty?
      end

      # facet 'geographical_coverages' do
      #     terms :geographical_coverage
      # end

      facet 'biographical_regions' do
        terms :biographical_region
        facet_filter :and, graph_filter unless graph_filter.empty?
      end

      facet 'languages' do
        terms 'languages.name'
        facet_filter :and, graph_filter unless graph_filter.empty?
      end

      facet('timeline') do
        date :published_on, interval: 'year'
        facet_filter :and, graph_filter unless graph_filter.empty?
      end

      facet('targets') do
        terms 'targets.title.exact'
        facet_filter :and, graph_filter unless graph_filter.empty?
      end
    end
  end

  # def attachment
  #   if file.present?
  #     path_to_file = Rails.root.to_s + '/public' + file_url.to_s
  #     Base64.encode64(open(path_to_file) { |f| f.read })
  #   else
  #     Base64.encode64('missing')
  #   end
  # end

  def thumbnail
    if thumb.present?
      thumb_url
    end
  end

  private

    # def update_thumb_info
    #   if thumb.present? && thumb_changed?
    #     self.content_type = thumb.file.content_type
    #     self.file_size = file.file.size
    #   end
    # end
    #

end
