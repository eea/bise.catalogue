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

ActiveRecord::Schema.define(:version => 20130321074448) do

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
    t.text     "author"
    t.text     "content"
    t.string   "language"
    t.text     "geographical_coverage"
    t.text     "biographical_region"
    t.text     "source_url"
    t.date     "published_on"
    t.boolean  "published"
    t.integer  "site_id"
    t.integer  "concepts_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "articles_concepts", :id => false, :force => true do |t|
    t.integer "article_id"
    t.integer "concept_id"
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

  create_table "documents", :force => true do |t|
    t.string   "title"
    t.string   "author"
    t.string   "description"
    t.string   "language"
    t.text     "geographical_coverage"
    t.text     "biographical_region"
    t.string   "source_url"
    t.date     "published_on"
    t.boolean  "published"
    t.integer  "downloads"
    t.string   "file"
    t.string   "content_type"
    t.float    "file_size"
    t.string   "md5hash"
    t.integer  "site_id"
    t.integer  "theme_id"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "documents_concepts", :id => false, :force => true do |t|
    t.integer "document_id"
    t.integer "concept_id"
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
    t.integer  "species_code"
    t.string   "binomial_name"
    t.string   "valid_name"
    t.string   "eunis_primary_name"
    t.string   "synonym_for"
    t.string   "taxonomic_rank"
    t.string   "taxonomy"
    t.string   "scientific_name_authorship"
    t.string   "scientific_name"
    t.string   "label"
    t.string   "genus"
    t.string   "species_group"
    t.string   "name_according_to_ID"
    t.boolean  "ignore_on_match"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "targets", :force => true do |t|
    t.string   "title"
    t.string   "short_desc"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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
