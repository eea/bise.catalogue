class Article < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :title
  attr_accessible :english_title
  attr_accessible :author
  attr_accessible :content

  attr_accessible :language_ids
  has_and_belongs_to_many :languages, :class_name => "Language", :join_table => "articles_languages", :foreign_key => "article_id"


  # attr_accessible :geographical_coverage
  attr_accessible :biographical_region

  attr_accessible :source_url

  attr_accessible :published_on
  attr_accessible :published

  attr_accessible :site_id
  belongs_to      :site

  attr_accessible :country_ids
  has_and_belongs_to_many :countries, :class_name => "Country", :join_table => "articles_countries", :foreign_key => "article_id"

  has_and_belongs_to_many :concepts, :class_name => "Concept", :join_table => "articles_concepts", :foreign_key => "article_id"

  validates_presence_of :site, :message => "can't be blank"
  validates_presence_of :title
  validates_presence_of :english_title
  validates_presence_of :author

  validates_presence_of :language_ids, :message => "can't be blank"

  # TAGS
  attr_accessible :tag_list
  acts_as_taggable

  index_name "#{Tire::Model::Search.index_prefix}articles"


  refresh = lambda {
    # self.update_index
    Tire::Index.new(index_name).refresh
  }
  after_save(&refresh)
  after_destroy(&refresh)

  settings :analysis => {
    :analyzer => {
      :search_analyzer => {
        :type => "custom",
        :tokenizer => "standard",
        :filter => ["lowercase", "snowball"]
      },
      :index_ngram_analyzer => {
        :type => "custom",
        :tokenizer => "standard",
        :filter => [ "lowercase", "snowball", "substring" ]
      }
    },
    :filter => {
      :substring => {
        :type => "nGram",
        :min_gram => 1,
        :max_gram => 40,
        :token_chars => [ "letter", "digit" ]
      }
    }
  } do
    mapping {

      indexes :site do
        indexes :id, :type => 'integer'
        indexes :name, :type => 'string', :index => :not_analyzed
        indexes :ngram_name, :index_analyzer => 'index_ngram_analyzer' , :search_analyzer => 'snowball'
      end

      indexes :title, :type => 'string', :index_analyzer => 'index_ngram_analyzer', :search_analyzer => 'search_analyzer'
      indexes :content, :store => 'yes', :type => 'string', :index_analyzer => 'index_ngram_analyzer', :search_analyzer => 'search_analyzer'

      # indexes :language, :type => 'string'
      indexes :languages do
        indexes :id         , :type => 'integer'
        indexes :name       , :type => 'string'                         , :index => :not_analyzed
        indexes :ngram_name , :index_analyzer => 'index_ngram_analyzer' , :search_analyzer => 'snowball'
      end

      indexes :countries do
        indexes :id         , :type => 'integer'
        indexes :name       , :type => 'string'                         , :index => :not_analyzed
        indexes :ngram_name , :index_analyzer => 'index_ngram_analyzer' , :search_analyzer => 'snowball'
      end

      indexes :tags do
        indexes :name       , :type => 'string'                         , :index => :not_analyzed
        indexes :ngram_name , :index_analyzer => 'index_ngram_analyzer' , :search_analyzer => 'snowball'
      end

      # indexes :content_without_tags, :type => 'string', :index_analyzer => 'index_ngram_analyzer', :search_analyzer => 'search_analyzer'
      # indexes :content_without_tags, :type => 'string',  :index_analyzer => 'index_ngram_analyzer', :search_analyzer => 'search_analyzer'
      # indexes :geographical_coverage, :type => 'string'
      indexes :biographical_region, :type => 'string', :index => :not_analyzed
      indexes :author, :type => 'string', :index => :not_analyzed
      indexes :published_on, :type => 'date'
    }
  end


  def to_indexed_json
    # self.to_json
    self.to_json :methods => [:content_without_tags]
  end

  def to_indexed_json
    {
      :site                      => { _type: 'site', _id: site.id, name: site.name, ngram_name: site.name },

      :title                     => title,
      :sort_title                => title,
      :english_title             => english_title,
      :content                   => content_without_tags,
      :author                    => author,
      :ngram_author              => author,
      :published_on              => published_on,

      :languages                 => languages.map { |l| { _type: 'language', _id: l.id, name: l.name, ngram_name: l.name } },

      :countries                 => countries.map { |c| { _type: 'country', _id: c.id, name: c.name, ngram_name: c.name } },
      :tags                      => tags.map { |c| { name: c.name, ngram_name: c.name } },

      :biographical_region       => biographical_region,
      :biographical_region_ngram => biographical_region
    }.to_json
  end

  def content_without_tags
    self.content.gsub(/<\/?[^>]*>/, "")
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

    tire.search :load => true, :page => params[:page], :per_page => 10 do

      query do
        boolean do
          should { string 'site.ngram_name:'           + params[:query].to_s }
          should { string 'title:'                     + params[:query].to_s }
          should { string 'english_title:'             + params[:query].to_s }
          should { string 'description:'               + params[:query].to_s }
          should { string 'ngram_author:'              + params[:query].to_s }
          should { string 'attachment:'                + params[:query].to_s }
          should { string 'countries.ngram_name:'      + params[:query].to_s }
          should { string 'languages.ngram_name:'      + params[:query].to_s }
          should { string 'tags.ngram_name:'           + params[:query].to_s }
          should { string 'biographical_region_ngram:' + params[:query].to_s}

          should   { string 'content_without_tags:' + params[:query].to_s }
          # must_not { string 'published:0' }
          # must_not { string 'published:0' }
        end
      end if params[:query].present?

      highlight :title, :content_without_tags

      filter :term, :author => params[:author] if params[:author].present?
      # filter :term, :geographical_coverage => params[:geographical_coverage] if params[:geographical_coverage].present?
      filter :term, :biographical_region => params[:biographical_region] if params[:biographical_region].present?
      filter :range, :published_on => { :gte => date_init , :lt => date_end } if params[:published_on].present?

      sort { by :published_on, "desc" } if params[:query].blank?

      facet 'authors' do
        terms :author
      end

      # facet 'geographical_coverages' do
      #     terms :geographical_coverage
      # end

      facet 'biographical_regions' do
        terms :biographical_region # , :script_field => true, :size => 50
      end

      facet('timeline') do
        date :published_on, :interval => 'year'
      end
    end
  end

end
