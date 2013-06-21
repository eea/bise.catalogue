class Habitat < ActiveRecord::Base

    include Tire::Model::Search
    include Tire::Model::Callbacks

    attr_accessible :code
    attr_accessible :comment
    attr_accessible :description
    attr_accessible :habitat_code
    attr_accessible :level
    attr_accessible :name
    attr_accessible :national_name
    attr_accessible :natura2000_code
    attr_accessible :originally_published_code
    attr_accessible :uri

    has_and_belongs_to_many :species , association_foreign_key: "species_id", join_table: "species_habitats", class_name: "Species"

    index_name "#{Tire::Model::Search.index_prefix}habitats"

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
