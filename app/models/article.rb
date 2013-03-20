# Article is a model for saving articles in the catalogue.
# It should contain at least a title, a content and a user.

class Article < ActiveRecord::Base

    include Tire::Model::Search
    include Tire::Model::Callbacks

    attr_accessible :title
    attr_accessible :author
    attr_accessible :content

    attr_accessible :language
    attr_accessible :geographical_coverage
    attr_accessible :biographical_region

    attr_accessible :source_url

    attr_accessible :published_on
    attr_accessible :published

    attr_accessible :site_id
    belongs_to              :site
    has_and_belongs_to_many :concepts, :class_name => "Concept", :join_table => "articles_concepts", :foreign_key => "article_id"

    # validates_presence_of :site
    validates_presence_of :title, :message => "can't be blank"


    index_name "#{Tire::Model::Search.index_prefix}articles"


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
            indexes :title, :type => 'string', :index_analyzer => 'index_ngram_analyzer', :search_analyzer => 'search_analyzer'
            indexes :content, :type => 'string', :index_analyzer => 'index_ngram_analyzer', :search_analyzer => 'search_analyzer'
            indexes :language, :type => 'string'
            indexes :geographical_coverage, :type => 'string'
            indexes :biographical_region, :type => 'string'
            indexes :author, :type => 'string'
            indexes :published_on, :type => 'date'
        }
    end


    def to_indexed_json
        self.to_json
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
                  should   { string 'title:' + params[:query].to_s }
                  should   { string 'content:' + params[:query].to_s }
                  # must_not { string 'published:0' }
                end
            end if params[:query].present?

            # highlight :title

            filter :term, :author => params[:author] if params[:author].present?
            filter :term, :geographical_coverage => params[:geographical_coverage] if params[:geographical_coverage].present?
            filter :term, :biographical_region => params[:biographical_region] if params[:biographical_region].present?
            filter :range, :published_on => { :gte => date_init , :lt => date_end } if params[:published_on].present?

            sort { by :published_on, "desc" } if params[:query].blank?

            facet 'authors' do
                terms :author
            end

            facet 'geographical_coverages' do
                terms :geographical_coverage
            end

            facet 'biographical_regions' do
                terms :biographical_region
            end

            facet('timeline') do
                date :published_on, :interval => 'year'
            end
        end
    end

end
