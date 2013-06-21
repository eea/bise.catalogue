class Country < ActiveRecord::Base

    include Tire::Model::Search
    include Tire::Model::Callbacks

    attr_accessible :code
    attr_accessible :name
    attr_accessible :eea
    attr_accessible :eu15
    attr_accessible :eu25
    attr_accessible :eu27
    attr_accessible :eu28


    attr_accessible :iso_code2
    attr_accessible :iso_code3
    attr_accessible :iso_n
    attr_accessible :iso_2_wcmc
    attr_accessible :iso_3_wcmc
    attr_accessible :iso_3_wcmc_parent
    attr_accessible :areucd
    attr_accessible :surface
    attr_accessible :population
    attr_accessible :capital

    attr_accessible :selection

    has_and_belongs_to_many :biogeo_regions , association_foreign_key: "biogeo_region_id", join_table: "countries_biogeoregions", class_name: "BiogeoRegion"
    has_and_belongs_to_many :protected_areas, association_foreign_key: "protected_area_id", join_table: "countries_protected_areas", class_name: "ProtectedArea"

    has_and_belongs_to_many :articles       , association_foreign_key: "article_id" , join_table: "articles_countries"  , class_name: "Article"
    has_and_belongs_to_many :documents      , association_foreign_key: "document_id", join_table: "documents_countries" , class_name: "Document"
    has_and_belongs_to_many :links          , association_foreign_key: "link_id"    , join_table: "links_countries"     , class_name: "Link"
    has_and_belongs_to_many :news           , association_foreign_key: "news_id"    , join_table: "news_countries"      , class_name: "News"

    index_name "#{Tire::Model::Search.index_prefix}countries"

    refresh = lambda { Tire::Index.new(index_name).refresh }
    after_save(&refresh)
    after_destroy(&refresh)

    mapping do
        indexes :id,    :index    => :not_analyzed
        indexes :name,  :analyzer => 'snowball'
    end

end
