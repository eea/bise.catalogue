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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170106124400) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "articles", force: true do |t|
    t.string   "title"
    t.string   "english_title"
    t.text     "author"
    t.text     "content"
    t.string   "language"
    t.text     "biographical_region"
    t.text     "source_url"
    t.date     "published_on"
    t.boolean  "published",           default: false
    t.integer  "site_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "approved",            default: false
    t.datetime "approved_at"
    t.integer  "creator_id"
    t.integer  "modifier_id"
  end

  add_index "articles", ["creator_id"], name: "index_articles_on_creator_id", using: :btree
  add_index "articles", ["modifier_id"], name: "index_articles_on_modifier_id", using: :btree

  create_table "articles_countries", id: false, force: true do |t|
    t.integer "article_id"
    t.integer "country_id"
  end

  create_table "articles_languages", id: false, force: true do |t|
    t.integer "article_id"
    t.integer "language_id"
  end

  create_table "biogeo_regions", force: true do |t|
    t.string   "uri"
    t.string   "code"
    t.string   "area_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "biogeo_regions_protected_areas", id: false, force: true do |t|
    t.integer "biogeo_region_id"
    t.integer "protected_area_id"
  end

  create_table "catalogue_searches", force: true do |t|
    t.string   "query"
    t.integer  "page"
    t.integer  "per"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "site"
    t.string   "source_db"
    t.string   "countries"
    t.string   "languages"
    t.string   "biographical_region"
    t.string   "species_group"
    t.string   "taxonomic_rank"
    t.string   "genus"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "format"
    t.string   "indexes"
    t.string   "queried_from_ip"
    t.string   "location"
    t.string   "search_type"
    t.string   "published_on"
    t.string   "strategytarget"
    t.string   "sort_on"
  end

  create_table "comfy_cms_blocks", force: true do |t|
    t.string   "identifier",     null: false
    t.text     "content"
    t.integer  "blockable_id"
    t.string   "blockable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_blocks", ["blockable_id", "blockable_type"], name: "index_comfy_cms_blocks_on_blockable_id_and_blockable_type", using: :btree
  add_index "comfy_cms_blocks", ["identifier"], name: "index_comfy_cms_blocks_on_identifier", using: :btree

  create_table "comfy_cms_categories", force: true do |t|
    t.integer "site_id",          null: false
    t.string  "label",            null: false
    t.string  "categorized_type", null: false
  end

  add_index "comfy_cms_categories", ["site_id", "categorized_type", "label"], name: "index_cms_categories_on_site_id_and_cat_type_and_label", unique: true, using: :btree

  create_table "comfy_cms_categorizations", force: true do |t|
    t.integer "category_id",      null: false
    t.string  "categorized_type", null: false
    t.integer "categorized_id",   null: false
  end

  add_index "comfy_cms_categorizations", ["category_id", "categorized_type", "categorized_id"], name: "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", unique: true, using: :btree

  create_table "comfy_cms_files", force: true do |t|
    t.integer  "site_id",                                    null: false
    t.integer  "block_id"
    t.string   "label",                                      null: false
    t.string   "file_file_name",                             null: false
    t.string   "file_content_type",                          null: false
    t.integer  "file_file_size",                             null: false
    t.string   "description",       limit: 2048
    t.integer  "position",                       default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_files", ["site_id", "block_id"], name: "index_comfy_cms_files_on_site_id_and_block_id", using: :btree
  add_index "comfy_cms_files", ["site_id", "file_file_name"], name: "index_comfy_cms_files_on_site_id_and_file_file_name", using: :btree
  add_index "comfy_cms_files", ["site_id", "label"], name: "index_comfy_cms_files_on_site_id_and_label", using: :btree
  add_index "comfy_cms_files", ["site_id", "position"], name: "index_comfy_cms_files_on_site_id_and_position", using: :btree

  create_table "comfy_cms_layouts", force: true do |t|
    t.integer  "site_id",                    null: false
    t.integer  "parent_id"
    t.string   "app_layout"
    t.string   "label",                      null: false
    t.string   "identifier",                 null: false
    t.text     "content"
    t.text     "css"
    t.text     "js"
    t.integer  "position",   default: 0,     null: false
    t.boolean  "is_shared",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_layouts", ["parent_id", "position"], name: "index_comfy_cms_layouts_on_parent_id_and_position", using: :btree
  add_index "comfy_cms_layouts", ["site_id", "identifier"], name: "index_comfy_cms_layouts_on_site_id_and_identifier", unique: true, using: :btree

  create_table "comfy_cms_pages", force: true do |t|
    t.integer  "site_id",                        null: false
    t.integer  "layout_id"
    t.integer  "parent_id"
    t.integer  "target_page_id"
    t.string   "label",                          null: false
    t.string   "slug"
    t.string   "full_path",                      null: false
    t.text     "content_cache"
    t.integer  "position",       default: 0,     null: false
    t.integer  "children_count", default: 0,     null: false
    t.boolean  "is_published",   default: true,  null: false
    t.boolean  "is_shared",      default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_pages", ["parent_id", "position"], name: "index_comfy_cms_pages_on_parent_id_and_position", using: :btree
  add_index "comfy_cms_pages", ["site_id", "full_path"], name: "index_comfy_cms_pages_on_site_id_and_full_path", using: :btree

  create_table "comfy_cms_revisions", force: true do |t|
    t.string   "record_type", null: false
    t.integer  "record_id",   null: false
    t.text     "data"
    t.datetime "created_at"
  end

  add_index "comfy_cms_revisions", ["record_type", "record_id", "created_at"], name: "index_cms_revisions_on_rtype_and_rid_and_created_at", using: :btree

  create_table "comfy_cms_sites", force: true do |t|
    t.string  "label",                       null: false
    t.string  "identifier",                  null: false
    t.string  "hostname",                    null: false
    t.string  "path"
    t.string  "locale",      default: "en",  null: false
    t.boolean "is_mirrored", default: false, null: false
  end

  add_index "comfy_cms_sites", ["hostname"], name: "index_comfy_cms_sites_on_hostname", using: :btree
  add_index "comfy_cms_sites", ["is_mirrored"], name: "index_comfy_cms_sites_on_is_mirrored", using: :btree

  create_table "comfy_cms_snippets", force: true do |t|
    t.integer  "site_id",                    null: false
    t.string   "label",                      null: false
    t.string   "identifier",                 null: false
    t.text     "content"
    t.integer  "position",   default: 0,     null: false
    t.boolean  "is_shared",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comfy_cms_snippets", ["site_id", "identifier"], name: "index_comfy_cms_snippets_on_site_id_and_identifier", unique: true, using: :btree
  add_index "comfy_cms_snippets", ["site_id", "position"], name: "index_comfy_cms_snippets_on_site_id_and_position", using: :btree

  create_table "countries", force: true do |t|
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
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "countries_biogeoregions", id: false, force: true do |t|
    t.integer "country_id"
    t.integer "biogeo_region_id"
  end

  create_table "countries_protected_areas", id: false, force: true do |t|
    t.integer "country_id"
    t.integer "protected_area_id"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "documents", force: true do |t|
    t.text     "title"
    t.text     "english_title"
    t.text     "author"
    t.text     "description"
    t.string   "language"
    t.text     "biographical_region"
    t.string   "source_url"
    t.date     "published_on"
    t.boolean  "published"
    t.boolean  "approved",            default: false
    t.integer  "downloads"
    t.string   "file"
    t.string   "content_type"
    t.float    "file_size"
    t.string   "md5hash"
    t.integer  "site_id"
    t.integer  "theme_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.datetime "approved_at"
    t.integer  "creator_id"
    t.integer  "modifier_id"
  end

  add_index "documents", ["creator_id"], name: "index_documents_on_creator_id", using: :btree
  add_index "documents", ["modifier_id"], name: "index_documents_on_modifier_id", using: :btree

  create_table "documents_countries", id: false, force: true do |t|
    t.integer "document_id"
    t.integer "country_id"
  end

  create_table "documents_languages", id: false, force: true do |t|
    t.integer "document_id"
    t.integer "language_id"
  end

  create_table "ecosystem_assessments", force: true do |t|
    t.string   "resource_type"
    t.string   "title"
    t.string   "language"
    t.string   "english_title"
    t.integer  "published_year"
    t.string   "origin"
    t.string   "url"
    t.boolean  "is_final"
    t.string   "availability"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "graphs", force: true do |t|
    t.text     "title"
    t.text     "english_title"
    t.text     "author"
    t.text     "content"
    t.string   "language"
    t.text     "biographical_region"
    t.string   "source_url"
    t.date     "published_on"
    t.boolean  "published",           default: false
    t.boolean  "approved",            default: false
    t.date     "approved_at"
    t.integer  "site_id"
    t.integer  "creator_id"
    t.integer  "modifier_id"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "has_part"
    t.string   "is_part_of"
    t.string   "is_replaced_by"
    t.string   "thumbnail_link"
    t.text     "embed_code"
    t.string   "thumb"
  end

  add_index "graphs", ["creator_id"], name: "index_graphs_on_creator_id", using: :btree
  add_index "graphs", ["modifier_id"], name: "index_graphs_on_modifier_id", using: :btree

  create_table "graphs_countries", id: false, force: true do |t|
    t.integer "graph_id"
    t.integer "country_id"
  end

  create_table "graphs_languages", id: false, force: true do |t|
    t.integer "graph_id"
    t.integer "language_id"
  end

  create_table "habitats", force: true do |t|
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
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.boolean  "approved",                  default: true
  end

  create_table "indicators", force: true do |t|
    t.text     "title"
    t.text     "english_title"
    t.text     "author"
    t.text     "content"
    t.string   "language"
    t.text     "biographical_region"
    t.string   "source_url"
    t.date     "published_on"
    t.boolean  "published",           default: false
    t.boolean  "approved",            default: false
    t.date     "approved_at"
    t.integer  "site_id"
    t.integer  "creator_id"
    t.integer  "modifier_id"
    t.string   "url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "has_part"
    t.string   "is_part_of"
    t.string   "is_replaced_by"
    t.string   "thumbnail_link"
    t.string   "indicator_set"
  end

  add_index "indicators", ["creator_id"], name: "index_indicators_on_creator_id", using: :btree
  add_index "indicators", ["modifier_id"], name: "index_indicators_on_modifier_id", using: :btree

  create_table "indicators_countries", id: false, force: true do |t|
    t.integer "indicator_id"
    t.integer "country_id"
  end

  create_table "indicators_languages", id: false, force: true do |t|
    t.integer "indicator_id"
    t.integer "language_id"
  end

  create_table "keyword_containers", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "keywords", force: true do |t|
    t.string   "name"
    t.integer  "keyword_container_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "keywords", ["keyword_container_id"], name: "index_keywords_on_keyword_container_id", using: :btree

  create_table "languages", force: true do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "code"
  end

  create_table "library_roles", force: true do |t|
    t.integer "user_id"
    t.integer "site_id"
    t.boolean "allowed", default: false
  end

  create_table "links", force: true do |t|
    t.text     "title"
    t.text     "english_title"
    t.text     "author"
    t.string   "language"
    t.text     "biographical_region"
    t.string   "url"
    t.text     "description"
    t.date     "published_on"
    t.boolean  "published",           default: false
    t.boolean  "approved",            default: false
    t.date     "approved_at"
    t.integer  "site_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "source_url"
    t.integer  "creator_id"
    t.integer  "modifier_id"
  end

  add_index "links", ["creator_id"], name: "index_links_on_creator_id", using: :btree
  add_index "links", ["modifier_id"], name: "index_links_on_modifier_id", using: :btree

  create_table "links_countries", id: false, force: true do |t|
    t.integer "link_id"
    t.integer "country_id"
  end

  create_table "links_languages", id: false, force: true do |t|
    t.integer "link_id"
    t.integer "language_id"
  end

  create_table "news", force: true do |t|
    t.boolean  "approved"
    t.datetime "approved_at"
    t.text     "author"
    t.text     "english_title"
    t.string   "language"
    t.datetime "published_on"
    t.string   "source"
    t.text     "title"
    t.string   "url"
    t.string   "abstract"
    t.string   "comment"
    t.string   "published"
    t.integer  "site_id"
    t.text     "biographical_region"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "news_languages", id: false, force: true do |t|
    t.integer "news_id"
    t.integer "language_id"
  end

  create_table "newss_countries", id: false, force: true do |t|
    t.integer "news_id"
    t.integer "country_id"
  end

  create_table "protected_areas", force: true do |t|
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
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "approved",         default: true
  end

  create_table "protected_areas_habitats", id: false, force: true do |t|
    t.integer "protected_area_id"
    t.integer "habitat_id"
  end

  create_table "sites", force: true do |t|
    t.string   "name"
    t.string   "origin_url"
    t.string   "description"
    t.integer  "articles_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "auth_token"
  end

  create_table "species", force: true do |t|
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
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.boolean  "approved",                   default: true
  end

  add_index "species", ["uri"], name: "index_species_on_uri", unique: true, using: :btree

  create_table "species_habitats", id: false, force: true do |t|
    t.integer "species_id"
    t.integer "habitat_id"
  end

  create_table "species_protected_areas", id: false, force: true do |t|
    t.integer "species_id"
    t.integer "protected_area_id"
  end

  create_table "species_translations", force: true do |t|
    t.string   "locale"
    t.string   "name"
    t.integer  "species_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "species_translations", ["species_id", "locale"], name: "index_species_translations_on_species_id_and_locale", unique: true, using: :btree

  create_table "strategy_actions", force: true do |t|
    t.string   "title"
    t.string   "short_desc"
    t.integer  "target_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "strategy_actions", ["target_id"], name: "index_strategy_actions_on_target_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "targets", force: true do |t|
    t.string   "title"
    t.string   "short_desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taxonomies", force: true do |t|
    t.string   "uri"
    t.integer  "code"
    t.string   "name"
    t.string   "level"
    t.integer  "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "taxonomies", ["parent_id"], name: "index_taxonomies_on_parent_id", using: :btree

  create_table "unprocessed_objects", force: true do |t|
    t.string   "model"
    t.string   "http_method"
    t.string   "field"
    t.string   "message"
    t.string   "ip"
    t.text     "params"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "login",               default: "",    null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "role_admin",          default: false
    t.boolean  "role_validator",      default: false
    t.boolean  "role_author",         default: false
    t.string   "name"
    t.string   "email"
  end

  add_index "users", ["login"], name: "index_users_on_login", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
