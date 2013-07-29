class Link < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :title
  attr_accessible :english_title
  attr_accessible :author

  attr_accessible :language_ids
  has_and_belongs_to_many :languages, :class_name => "Language", :join_table => "links_languages", :foreign_key => "link_id"

  attr_accessible :biographical_region

  attr_accessible :source

  attr_accessible :published_on
  attr_accessible :published

  attr_accessible :site_id
  belongs_to      :site

  attr_accessible :country_ids
  has_and_belongs_to_many :countries, :class_name => "Country", :join_table => "links_countries", :foreign_key => "link_id"

  attr_accessible :approved
  attr_accessible :approved_at
  attr_accessible :language
  attr_accessible :url
  attr_accessible :description
  attr_accessible :comment

  # validates_presence_of :site
  validates_presence_of :title, :message => "cannot be blank"
  validates_presence_of :url, :message => "cannot be blank"
  validates_presence_of :author, :message => "cannot be blank"
  validates_presence_of :site, :message => "cannot be blank"
  validates_format_of :url, :with => /^(((http|https):\/\/))[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix


  index_name "#{Tire::Model::Search.index_prefix}links"

  refresh = lambda { Tire::Index.new(index_name).refresh }
  after_save(&refresh)
  after_destroy(&refresh)

  settings :analysis => {
    :analyzer => {
      :search_analyzer => {
        :tokenizer => "keyword",
        :filter => ["lowercase"]
      },
      :index_ngram_analyzer => {
        :tokenizer => "keyword",
        :filter => ["lowercase", "substring"],
        :type => "custom"
      }
    },
    :filter => {
      :substring => {
        :type => "nGram",
        :min_gram => 1,
        :max_gram => 20
      }
    }
  } do
    mapping {
      indexes :id, :index    => :not_analyzed
      indexes :title, :type => 'string', :index_analyzer => 'index_ngram_analyzer', :search_analyzer => 'search_analyzer'
      indexes :language, :type => 'string'
      indexes :author, :type => 'string', :index => :not_analyzed
      indexes :url, :type => 'string'
      indexes :source, :type => 'string'
      indexes :published_on, :type => 'date'
      indexes :biographical_region, :type => 'string', :index => :not_analyzed
      indexes :countries do
        indexes :id, :type => 'integer'
        indexes :name, :type => 'string', :index => :not_analyzed
      end
    }
  end

  def to_indexed_json
    {
      :title                  => title,
      :description            => description,
      :author                 => author,
      :published_on           => published_on,

      :countries              => countries.map { |c| { :_type  => 'country', :_id    => c.id, :name   => c.name  } },

      :biographical_region    => biographical_region
    }.to_json
  end

  def self.search(params)

    date_init = nil
    date_end = nil

    if params[:published_on].present?
      year = params[:published_on].to_i
      logger.debug ':: year => ' + year.to_s
      date_init = DateTime.new(year, 1, 1)
      date_end = DateTime.new(year, 12, 31)
    end

    # Facet Filter
    link_filter = []
    link_filter << { :term => { :author => params[:author] }} if params[:author].present?
    link_filter << { :term => { 'countries.name' => params[:countries].split(/\//) }} if params[:countries].present?
    link_filter << { :term => { :biographical_region => params[:biographical_region] }} if params[:biographical_region].present?
    link_filter << { :range=> { :published_on => { :gte => date_init , :lt => date_end }}} if params[:published_on].present?

    tire.search :load => true, :page => params[:page], :per_page => 10 do

      query do
        boolean do
          should   { string 'title:' + params[:query].to_s }
          should   { string 'url:' + params[:query].to_s }
          # must_not { string 'published:0' }
        end
      end if params[:query].present?

      highlight :title, :url

      filter :term, :author => params[:author] if params[:author].present?
      # filter :term, :geographical_coverage => params[:geographical_coverage] if params[:geographical_coverage].present?
      filter :term, :biographical_region => params[:biographical_region] if params[:biographical_region].present?
      filter :range, :published_on => { :gte => date_init , :lt => date_end } if params[:published_on].present?
      filter :term, 'countries.name' => params[:countries].split(/\//) if params[:countries].present?
      sort { by :published_on, "desc" } if params[:query].blank?

      facet 'authors' do
        terms :author
        facet_filter :and, link_filter unless link_filter.empty?
      end

      # facet 'geographical_coverages' do
      #     terms :geographical_coverage
      # end

      facet 'biographical_regions' do
        terms :biographical_region
        facet_filter :and, link_filter unless link_filter.empty?
      end

      facet('timeline') do
        date :published_on, :interval => 'year'
        facet_filter :and, link_filter unless link_filter.empty?
      end

      facet 'countries' do
        terms 'countries.name'
        facet_filter :and, link_filter unless link_filter.empty?
      end
    end
  end
end
