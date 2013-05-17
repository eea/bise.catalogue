class ProtectedArea < ActiveRecord::Base

    include Tire::Model::Search
    include Tire::Model::Callbacks

    attr_accessible :area
    attr_accessible :iucnat
    attr_accessible :code
    attr_accessible :designation_year
    attr_accessible :lat
    attr_accessible :length
    attr_accessible :long
    attr_accessible :name
    attr_accessible :nuts_code
    attr_accessible :source_db
    attr_accessible :uri

    index_name "#{Tire::Model::Search.index_prefix}protected_areas"

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
            indexes :name, :type => 'string', :index_analyzer => 'index_ngram_analyzer', :search_analyzer => 'search_analyzer'
        }
    end

    def self.search(params)
        tire.search :load => true, :page => params[:page], :per_page => 10 do
            query do
                 boolean do
                  should   { string 'name:' + params[:query].to_s }
                end
            end if params[:query].present?

            highlight :name
        end
    end

end
