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

    validates_presence_of :title, :on => :create, :message => "can't be blank"


    # settings :number_of_shards => 1,
    #         :number_of_replicas => 1,
    #         :analysis => {
    #             # :filter => {
    #             #     :title_ngram  => {
    #             #         "type"     => "nGram",
    #             #         "max_gram" => 5,
    #             #         "min_gram" => 3
    #             #     }
    #             # },
    #             :analyzer => {
    #                 :title_analyzer => {
    #                     :type         => "snowball",
    #                     :language     => "English"
    #                     # "filter"       => ["stop", "title_ngram"],
    #                     # :tokenizer    => "lowercase",
    #                 }
    #             }
    #         } do
    ########## MAPPING goes here
    # end

    # Tire.index('ngrams-and-tire') do
    #     create :settings => {
    #         "index" => {
    #             "analysis" => {
    #                 "filter" => {
    #                     # Let's define a custom ngram filter
    #                     #
    #                     "url_ngram"  => {
    #                         "type"     => "nGram",
    #                         "max_gram" => 5,
    #                         "min_gram" => 3
    #                     },
    #                     # Let's define a custom stop words filter
    #                     #
    #                     "url_stop"  => {
    #                         "type"      => "stop",
    #                         "stopwords" => ["http", "https"]
    #                     }
    #                 },
    #                 "analyzer" => {
    #                     "url_analyzer" => {
    #                         # First, lowercase everything with the built-in tokenizer
    #                         #
    #                         "tokenizer"    => "lowercase",
    #                         # Then, define our analyzer chain: remove generic stopwords,
    #                         # remove URL specific stopwords, apply our custom ngram filter
    #                         #
    #                         "filter"       => ["stop", "url_stop", "url_ngram"],
    #                         "type"         => "custom"
    #                     }
    #                 }
    #             }
    #         }
    #     },
    #     :mappings => {
    #         "articles" => {
    #             "properties" => {
    #                 "title" => {
    #                     "boost"    => 10,
    #                     "type"     => "string",
    #                     # Let's use our custom analyzer for the `url` field
    #                     #
    #                     "analyzer" => "url_analyzer"
    #                 }
    #             }
    #         }
    #     }

    # end


    mapping do
        indexes :id,           :index    => :not_analyzed
        indexes :title,        :type => 'string', :boots => 300                    #:analyzer => 'whitespace', :tokenizer => 'nGram' , :boost => 100
        indexes :content       #,      :analyzer => 'snowball'
        indexes :author        #,       :analyzer => 'snowball'
        indexes :published_on, :type => 'date' #, :include_in_all => false
    end


    # mapping do
    #     indexes :id,           :index    => :not_analyzed
    #     indexes :title,        :type => 'string', :boots => 300                    #:analyzer => 'whitespace', :tokenizer => 'nGram' , :boost => 100
    #     indexes :content       #,      :analyzer => 'snowball'
    #     indexes :author        #,       :analyzer => 'snowball'
    #     indexes :published_on, :type => 'date' #, :include_in_all => false
    # end

    def self.search(params)

        date_init = nil
        date_end = nil

        if params[:published_on].present?
            year = params[:published_on].to_i
            logger.debug ':: year => ' + year.to_s
            date_init = DateTime.new(year, 1, 1)
            date_end = DateTime.new(year, 12, 31)
        end



        # :load => true,
        results = tire.search :page => params[:page], :per_page => 10 do

            query { string params[:query], :default_operator => "AND"} if params[:query].present?
            highlight :title

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
