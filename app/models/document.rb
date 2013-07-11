class Document < ActiveRecord::Base

  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :site_id
  belongs_to      :site
  validates_presence_of :site, :message => "can't be blank"

  attr_accessible :title
  validates_presence_of :title, :message => "can't be blank", :length => { :maximum => 255 }

  attr_accessible :english_title
  validates_presence_of :english_title, :message => "can't be blank", :length => { :maximum => 255 }

  attr_accessible :author
  validates_presence_of :author, :message => "can't be blank"

  attr_accessible :description

  attr_accessible :language_ids
  has_and_belongs_to_many :languages, :class_name => "Language", :join_table => "documents_languages", :foreign_key => "document_id"
  validates_presence_of :language_ids, :message => "can't be blank"

  #attr_accessible :geographical_coverage
  attr_accessible :biographical_region

  attr_accessible :source_url

  attr_accessible :published_on
  validate :published_on_is_valid_date

  attr_accessible :published

  attr_accessible :downloads

  attr_accessible :thumbnail
  attr_accessible :file
  mount_uploader :file, FileUploader
  validates_presence_of :file, :on => :create, :message => "can't be blank"
  validate :uniqueness_of_md5hash, :on => :create
  before_validation :compute_hash
  before_save :update_file_info

  attr_accessible :country_ids
  has_and_belongs_to_many :countries, :class_name => "Country", :join_table => "documents_countries", :foreign_key => "document_id"
  has_and_belongs_to_many :concepts, :class_name => "Concept", :join_table => "documents_concepts", :foreign_key => "document_id"

  # TAGS
  attr_accessible :tag_list
  acts_as_taggable

  # INDEXES
  index_name "#{Tire::Model::Search.index_prefix}documents"
  refresh = lambda { Tire::Index.new(index_name).refresh }
  after_save(&refresh)
  after_destroy(&refresh)


  # ----- TIRE SETTINGS -----


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
    # :_source => { :excludes => ['attachment'] }
    mapping :_source => { :excludes => ['attachment'] } do

      indexes :site do
        indexes :id, :type => 'integer'
        indexes :name, :type => 'string', :index => :not_analyzed
      end

      indexes :id            , :index    => :not_analyzed
      indexes :title         , :analyzer => 'snowball'    , :index_analyzer => 'index_ngram_analyzer' , :search_analyzer => 'search_analyzer' , :boost => 100
      indexes :sort_title    , :index    => :not_analyzed
      indexes :english_title , :analyzer => 'snowball'    , :index_analyzer => 'index_ngram_analyzer' , :search_analyzer => 'search_analyzer' , :boost => 100
      indexes :description   , :analyzer => 'snowball'    , :index_analyzer => 'index_ngram_analyzer' , :search_analyzer => 'search_analyzer'

      # indexes :language, :index => :not_analyzed
      indexes :languages do
        indexes :id   , :type => 'integer'
        indexes :name , :type => 'string'  , :index => :not_analyzed
      end

      indexes :published_on , :type => 'date'                           , :index => :not_analyzed
      indexes :author       , :type => 'string'                         , :index => :not_analyzed

      indexes :countries do
        indexes :id, :type => 'integer'
        indexes :name, :type => 'string', :index => :not_analyzed
      end

      indexes :tags do
        indexes :name, :type => 'string', :index => :not_analyzed
      end

      indexes :biographical_region, :type => 'string', :index => :not_analyzed
      indexes :attachment, :type => 'attachment', :fields => {
        :date       => { :store => 'yes' },
        :file       => { :index => 'no'},
        # :title      => { :store => 'yes' },
        # :name       => { :store => 'yes' },  # exists?!?
        :content    => { :store => 'yes', :term_vector => 'with_positions_offsets', :index_analyzer => 'index_ngram_analyzer', :search_analyzer => 'search_analyzer' },
        :attachment => { :store => 'yes', :term_vector => 'with_positions_offsets' },
        :author     => { :analyzer => 'index_ngram_analyzer' }
      }
    end
  end

  # def to_csv
  #   CSV.generate do |csv|
  #     csv << Document.column_names
  #     Document.find(:all).each do |product|
  #       csv << self.attributes.values_at(*Document.column_names)
  #     end
  #     # all.each do |product|
  #     #     csv << product.attributes.values_at(*column_names)
  #     # end
  #   end
  # end

  def to_indexed_json
    {
      :site                   => { :_type => 'site', :_id => site.id, :name => site.name },

      :title                  => title,
      :sort_title             => title,
      :english_title          => english_title,
      :description            => description,
      :author                 => author,
      :published_on           => published_on,

      :languages              => languages.map { |l| { :_type  => 'language', :_id => l.id, :name => l.name } },

      :countries              => countries.map { |c| { :_type  => 'country', :_id => c.id, :name => c.name } },
      :tags                   => tags.map { |c| { :name => c.name } },

      :biographical_region    => biographical_region,
      :attachment             => attachment
    }.to_json
  end


  # ----- SEARCH  -----

  def self.search(params)

    date_init, date_end = nil
    if params[:published_on].present?
      date_init = DateTime.new(params[:published_on].to_i, 1, 1)
      date_end = DateTime.new(params[:published_on].to_i, 12, 31)
    end

    # Facet Filter
    doc_filter = []
    doc_filter << { :term => { :author => params[:author] }} if params[:author].present?
    doc_filter << { :term => { 'countries.name' => params[:countries].split(/\//) }} if params[:countries].present?
    doc_filter << { :term => { 'languages.name' => params[:languages].split(/\//) }} if params[:languages].present?
    doc_filter << { :term => { :biographical_region => params[:biographical_region] }} if params[:biographical_region].present?
    doc_filter << { :range=> { :published_on => { :gte => date_init , :lt => date_end }}} if params[:published_on].present?


    tire.search :load => true, :page => params[:page], :per_page => params[:per_page] do
      query do
        filtered do
          query do
            string 'title:' + params[:query].to_s
            string 'english_title:' + params[:query].to_s
            should   { string 'description:' + params[:query].to_s }
            # string 'description:' + params[:query].to_s
            string 'attachment:' + params[:query].to_s
            string 'tags.name:' + params[:query].to_s
          end
          # filter :term, :author => params[:author] if params[:author].present?
          # filter :or, :terms => { :organization_ids => current_user.followed_performers.collect(&:id).map(&:to_s) },
          #           :terms => { :watcher_ids =>      [current_user.id.to_s] }
        end
        # boolean do
        #     should   { string 'title:' + params[:query].to_s }
        #     should   { string 'description:' + params[:query].to_s }
        #     should   { string 'attachment:' + params[:query].to_s }
        #     # must_not { string 'published:0' }
        # end
      end if params[:query].present?

      # highlight :name, :options => { :tag => '<strong class="highlight">' }
      highlight :title, :attachment, :description

      filter :term, :author => params[:author] if params[:author].present?
      # filter :or, :terms => { :countries_names => params[:countries].split(/\//) } if params[:countries].present?
      # filter :term, 'countries.name' => ['Spain', 'Italy']  # if params[:countries].present?
      filter :term, 'countries.name' => params[:countries].split(/\//) if params[:countries].present?
      filter :term, 'languages.name' => params[:languages].split(/\//) if params[:languages].present?
      # filter :term, :countries_names => params[:countries].split(/\//) if params[:countries].present?
      filter :term, :biographical_region => params[:biographical_region] if params[:biographical_region].present?
      filter :range, :published_on => { :gte => date_init , :lt => date_end } if params[:published_on].present?

      if params[:sort].present? and params[:sort] != "published_on"
        sort { by params[:sort].to_sym, "asc" }
      else
        sort { by :published_on, "desc" }
      end


      facet 'sites' do
        terms 'site.name'
        facet_filter :and, doc_filter unless doc_filter.empty?
      end

      facet 'authors' do
        terms :author
        facet_filter :and, doc_filter unless doc_filter.empty?
      end

      facet 'countries' do
        terms 'countries.name'
        facet_filter :and, doc_filter unless doc_filter.empty?
      end

      facet 'biographical_regions' do
        terms :biographical_region
        facet_filter :and, doc_filter unless doc_filter.empty?
      end

      facet 'languages' do
        terms 'languages.name'
        facet_filter :and, doc_filter unless doc_filter.empty?
      end

      facet('timeline') do
        date :published_on, :interval => 'year'
        facet_filter :and, doc_filter unless doc_filter.empty?
      end
    end
  end

  def attachment
    puts ":: Indexing document #{self.id}   => #{file_url.to_s}"
    if file.present?
      path_to_file = Rails.root.to_s + '/public' + file_url.to_s
      Base64.encode64(open(path_to_file) { |f| f.read })
    else
      Base64.encode64("missing")
    end
  end

  def thumbnail
    if file.present?
      name = file.file.filename
      dot = name.rindex('.') - 1
      thumbnail_name = "#{name[0..dot]}_1.jpg"
      file_url[0..file_url.rindex('/')] + thumbnail_name
    end
  end

  def uniqueness_of_md5hash
    if Document.exists?(:md5hash => self.md5hash)
      errors.add :file, "is already registered. Documents must be unique."
    end
  end

  # DEPRECATED
  def generate_thumbnail
    begin
      require 'docsplit'
      file = "#{Rails.root}/public#{@document.file_url}"
      last_index = file.rindex '/'
      output = file[0..last_index]
      Docsplit.extract_images file, size: '180x', format: [:jpg], pages: 1, output: output
    rescue Exception => e
      logger.debug { ":: Document thumbnail can't be generated" }
    end
  end

  private

    def update_file_info
      if file.present? && file_changed?
        self.content_type = file.file.content_type
        self.file_size = file.file.size
      end
    end

    def compute_hash
      # puts ":: compute_hash => #{self.file.nil?} - #{self.file.size}"
      self.md5hash = Digest::MD5.hexdigest(self.file.read) if self.file?
    end

    def published_on_is_valid_date
      # begin
      #   DateTime.parse(published_on)
      # rescue Exception => e
      #   errors.add(:published_on, 'must be a valid date')
      # end

      errors.add(:published_on, 'must be a valid date') unless published_on.class == Date
      # errors.add(:published_on, 'must be a valid date') if (DateTime.parse(published_on) rescue Exception)
    end

end
