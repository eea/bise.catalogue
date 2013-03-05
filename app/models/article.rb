# Article is a model for saving articles in the catalogue.
# It should contain at least a title, a content and a user.

class Article < ActiveRecord::Base

    include Tire::Model::Search
    include Tire::Model::Callbacks

    attr_accessible :title
    attr_accessible :content
    attr_accessible :author
    attr_accessible :source_url
    attr_accessible :published_on
    attr_accessible :published

    belongs_to :site

    validates_presence_of :title, :on => :create, :message => "can't be blank"


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
            filter :range, :published_on => { :gte => date_init , :lt => date_end } if params[:published_on].present?

            sort { by :published_on, "desc" } if params[:query].blank?

            facet 'authors' do
                terms :author
            end

            facet('timeline') do
                date :published_on, :interval => 'year'
            end

        end

    end

end
