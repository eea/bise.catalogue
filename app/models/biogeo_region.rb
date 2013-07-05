class BiogeoRegion < ActiveRecord::Base

    include Tire::Model::Search
    include Tire::Model::Callbacks

    attr_accessible :code
    attr_accessible :area_name

    has_many :countries
    has_and_belongs_to_many :protected_areas, association_foreign_key: "protected_area_id", join_table: "biogeo_regions_protected_areas", class_name: "ProtectedArea"

    index_name "#{Tire::Model::Search.index_prefix}biogeoregions"

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
        mapping do
            # indexes :id, :index    => :not_analyzed
            indexes :code, :type => 'string', :index => :not_analyzed
            indexes :area_name, :type => 'string', :index => :not_analyzed
        end
    end

    def to_indexed_json
        {
            code: code,
            area_name: area_name
        }
    end

end
