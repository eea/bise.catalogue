# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130705105229) do

  create_table "actions", :force => true do |t|
    t.string   "title"
    t.string   "short_desc"
    t.integer  "target_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "actions", ["target_id"], :name => "index_actions_on_target_id"

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.string   "english_title"
    t.text     "author"
    t.text     "content"
    t.string   "language"
    t.text     "biographical_region"
    t.text     "source_url"
    t.date     "published_on"
    t.boolean  "published",           :default => false
    t.integer  "site_id"
    t.integer  "concepts_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "articles_concepts", :id => false, :force => true do |t|
    t.integer "article_id"
    t.integer "concept_id"
  end

  create_table "articles_countries", :id => false, :force => true do |t|
    t.integer "article_id"
    t.integer "country_id"
  end

  create_table "articles_languages", :id => false, :force => true do |t|
    t.integer "article_id"
    t.integer "language_id"
  end

  create_table "biogeo_regions", :force => true do |t|
    t.string   "uri"
    t.string   "code"
    t.string   "area_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "biogeo_regions_protected_areas", :id => false, :force => true do |t|
    t.integer "biogeo_region_id"
    t.integer "protected_area_id"
  end

  create_table "concepts", :force => true do |t|
    t.string   "title"
    t.integer  "parent"
    t.text     "definition"
    t.integer  "themes_id"
    t.integer  "articles_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "uri"
    t.string   "name"
    t.string   "code"
    t.boolean  "eu15"
    t.boolean  "eu25"
    t.boolean  "eu27"
    t.boolean  "eu28"
    t.boolean  "eea"
    t.string   "iso_code2"
    t.string   "iso_code3"
    t.integer  "iso_n"
    t.string   "iso_2_wcmc"
    t.string   "iso_3_wcmc"
    t.string   "iso_3_wcmc_parent"
    t.string   "areucd"
    t.integer  "surface"
    t.integer  "population"
    t.string   "capital"
    t.boolean  "selection"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "countries_biogeoregions", :id => false, :force => true do |t|
    t.integer "country_id"
    t.integer "biogeo_region_id"
  end

  create_table "countries_protected_areas", :id => false, :force => true do |t|
    t.integer "country_id"
    t.integer "protected_area_id"
  end

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.string   "english_title"
    t.string   "author"
    t.string   "description"
    t.string   "language"
    t.text     "biographical_region"
    t.string   "source_url"
    t.date     "published_on"
    t.boolean  "published"
    t.boolean  "approved"
    t.integer  "downloads"
    t.string   "file"
    t.string   "content_type"
    t.float    "file_size"
    t.string   "md5hash"
    t.integer  "site_id"
    t.integer  "theme_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "documents_concepts", :id => false, :force => true do |t|
    t.integer "document_id"
    t.integer "concept_id"
  end

  create_table "documents_countries", :id => false, :force => true do |t|
    t.integer "document_id"
    t.integer "country_id"
  end

  create_table "documents_languages", :id => false, :force => true do |t|
    t.integer "document_id"
    t.integer "language_id"
  end

  create_table "ecosystem_assessments", :force => true do |t|
    t.string   "resource_type"
    t.string   "title"
    t.string   "language"
    t.string   "english_title"
    t.integer  "published_year"
    t.string   "origin"
    t.string   "url"
    t.boolean  "is_final"
    t.string   "availability"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "habitats", :force => true do |t|
    t.string   "uri"
    t.integer  "code"
    t.string   "name"
    t.integer  "natura2000_code"
    t.string   "habitat_code"
    t.integer  "level"
    t.integer  "originally_published_code"
    t.text     "description"
    t.text     "comment"
    t.string   "national_name"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "languages", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "links", :force => true do |t|
    t.string   "title"
    t.string   "english_title"
    t.string   "author"
    t.datetime "published_on"
    t.boolean  "published",           :default => false
    t.string   "language"
    t.string   "source"
    t.boolean  "approved"
    t.text     "biographical_region"
    t.string   "url"
    t.string   "comment"
    t.string   "description"
    t.datetime "approved_at"
    t.integer  "site_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "links_countries", :id => false, :force => true do |t|
    t.integer "link_id"
    t.integer "country_id"
  end

  create_table "links_languages", :id => false, :force => true do |t|
    t.integer "link_id"
    t.integer "language_id"
  end

  create_table "news", :force => true do |t|
    t.boolean  "approved"
    t.datetime "approved_at"
    t.string   "author"
    t.string   "english_title"
    t.string   "language"
    t.datetime "published_on"
    t.string   "source"
    t.string   "title"
    t.string   "url"
    t.string   "abstract"
    t.string   "comment"
    t.string   "published"
    t.integer  "site_id"
    t.text     "biographical_region"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "news_languages", :id => false, :force => true do |t|
    t.integer "news_id"
    t.integer "language_id"
  end

  create_table "newss_countries", :id => false, :force => true do |t|
    t.integer "news_id"
    t.integer "country_id"
  end

  create_table "protected_areas", :force => true do |t|
    t.string   "code"
    t.string   "iucnat"
    t.string   "uri"
    t.string   "name"
    t.integer  "designation_year"
    t.string   "nuts_code"
    t.float    "area"
    t.float    "length"
    t.float    "long"
    t.float    "lat"
    t.string   "source_db"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "protected_areas_habitats", :id => false, :force => true do |t|
    t.integer "protected_area_id"
    t.integer "habitat_id"
  end

  create_table "sites", :force => true do |t|
    t.string   "name"
    t.string   "origin_url"
    t.string   "description"
    t.integer  "articles_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "species", :force => true do |t|
    t.string   "uri"
    t.integer  "species_code"
    t.string   "binomial_name"
    t.string   "valid_name"
    t.string   "eunis_primary_name"
    t.string   "synonym_for"
    t.string   "taxonomic_rank"
    t.string   "scientific_name_authorship"
    t.string   "scientific_name"
    t.string   "label"
    t.string   "genus"
    t.string   "species_group"
    t.string   "name_according_to_ID"
    t.boolean  "ignore_on_match"
    t.integer  "taxonomy_id"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "species_habitats", :id => false, :force => true do |t|
    t.integer "species_id"
    t.integer "habitat_id"
  end

  create_table "species_protected_areas", :id => false, :force => true do |t|
    t.integer "species_id"
    t.integer "protected_area_id"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "targets", :force => true do |t|
    t.string   "title"
    t.string   "short_desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "taxonomies", :force => true do |t|
    t.string   "uri"
    t.integer  "code"
    t.string   "name"
    t.string   "level"
    t.integer  "parent_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "taxonomies", ["parent_id"], :name => "index_taxonomies_on_parent_id"

  create_table "themes", :force => true do |t|
    t.string   "title"
    t.integer  "concepts_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "themes_concepts", :id => false, :force => true do |t|
    t.integer "theme_id"
    t.integer "concept_id"
  end

end
