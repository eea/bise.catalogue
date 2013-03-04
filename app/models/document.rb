class Document < ActiveRecord::Base

    include Tire::Model::Search
    include Tire::Model::Callbacks

    attr_accessible :document_id
    attr_accessible :name
    attr_accessible :description
    attr_accessible :author
    attr_accessible :source_url
    attr_accessible :downloads
    attr_accessible :file
    mount_uploader :file, FileUploader

    attr_accessible :published_on
    attr_accessible :published

    validates_presence_of :name, :on => :create, :message => "Can't be blank."
    validates_presence_of :file, :on => :create, :message => "Can't be blank."
    validate :uniqueness_of_md5hash, :on => :create
    before_validation :compute_hash
    before_save :update_file_info


    index_name "#{Tire::Model::Search.index_prefix}documents"


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
        mapping :_source => { :excludes => ['attachment'] } do
            indexes :id, :index    => :not_analyzed
            indexes :name, :analyzer => 'snowball', :index_analyzer => 'index_ngram_analyzer', :search_analyzer => 'search_analyzer', :boost => 100
            indexes :description, :index_analyzer => 'index_ngram_analyzer', :search_analyzer => 'search_analyzer'
            indexes :created_at, :type => 'date'
            indexes :author, :type => 'string'
            indexes :attachment, :type => 'attachment', :fields => {
                :name       => { :store => 'yes' },  # exists?!?
                :content    => { :store => 'yes' },
                :title      => { :store => 'yes' },
                :attachment => { :term_vector => 'with_positions_offsets', :store => 'yes' },
                :date       => { :store => 'yes' }
            }
            #, :index_analyzer => 'index_ngram_analyzer', :search_analyzer => 'search_analyzer'
        end
    end

    # :_source => { :excludes => ['attachment'] }
    # mapping do
    #     indexes :id, :index    => :not_analyzed
    #     indexes :name, :analyzer => 'snowball', :boost => 100
    #     indexes :description, :analyzer => 'snowball'
    #     indexes :created_at, :type => 'date'
    #     indexes :attachment, :type => 'attachment'
    #     # indexes :attachment, :type => 'attachment', :fields => {
    #     #     :name       => { :store => 'yes' },
    #     #     :content    => { :store => 'yes' },
    #     #     :title      => { :store => 'yes' },
    #     #     :attachment => { :term_vector => 'with_positions_offsets', :store => 'yes' },
    #     #     :date       => { :store => 'yes' }
    #     # }
    # end

    # after_save do
    #     self.update_index # if self.state == 'published'
    # end

    def self.search(params)
        tire.search :load => true, :page => params[:page], :per_page => 10 do
            query do
                 boolean do
                  should   { string 'name:' + params[:query].to_s }
                  should   { string 'description:' + params[:query].to_s }
                  # must_not { string 'published:0' }
                end
            end if params[:query].present?

            # highlight :name, :options => { :tag => '<strong class="highlight">' }
            highlight :name, :attachment, :description

            filter :term, :author => params[:author] if params[:author].present?

            sort { by :created_at, "desc" } # if params[:query].blank?

            facet 'authors' do
                terms :author
            end

            facet('timeline') do
                date :created_at, :interval => 'year'
            end
        end
    end

    def to_indexed_json
        to_json(:methods => [:attachment])
    end

    def attachment
        if file.present?
            path_to_file = Rails.root.to_s + '/public' + file_url.to_s
            Base64.encode64(open(path_to_file) { |f| f.read })
        else
            Base64.encode64("missing")
        end
    end

    def uniqueness_of_md5hash
        if Document.exists?(:md5hash => self.md5hash)
            errors.add(:file, "File is already registered.")
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
            self.md5hash = Digest::MD5.hexdigest(self.file.read) if self.file?
        end

end
