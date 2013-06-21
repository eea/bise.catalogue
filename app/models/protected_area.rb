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

    has_and_belongs_to_many :biogeo_regions , association_foreign_key: "biogeo_region_id", join_table: "biogeo_regions_protected_areas", class_name: "BioGeoRegion"
    has_and_belongs_to_many :countries , association_foreign_key: "country_id", join_table: "countries_protected_areas", class_name: "Country"
    has_and_belongs_to_many :species , association_foreign_key: "species_id", join_table: "species_protected_areas", class_name: "Species"

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

            indexes :source_db, :type => 'string', :index => :not_analyzed
            indexes :designation_year, :type => 'integer', :index => :not_analyzed
        }
    end

    def self.search(params)
        tire.search :load => true, :page => params[:page], :per_page => 20 do
            query do
                 boolean do
                  should   { string 'name:' + params[:query].to_s }
                end
            end if params[:query].present?

            highlight :name

            facet 'source_dbs' do
                terms :source_db
            end

            facet('designation_years') do
                terms :designation_year, size: 15
            end
        end
    end

end
