class Document < ActiveRecord::Base

    include Tire::Model::Search
    include Tire::Model::Callbacks

    attr_accessible :document_id
    attr_accessible :name
    attr_accessible :description
    attr_accessible :author
    attr_accessible :downloads    ########################## ELASTIC SEARCH


    # :_source => { :excludes => ['attachment'] }
    mapping do
        indexes :id, :index    => :not_analyzed
        indexes :name, :analyzer => 'snowball', :boost => 100
        indexes :description, :analyzer => 'snowball'
        indexes :created_at, :type => 'date'
        indexes :attachment, :type => 'attachment'
        # indexes :attachment, :type => 'attachment', :fields => {
        #     :name       => { :store => 'yes' },
        #     :content    => { :store => 'yes' },
        #     :title      => { :store => 'yes' },
        #     :attachment => { :term_vector => 'with_positions_offsets', :store => 'yes' },
        #     :date       => { :store => 'yes' }
        # }
    end



    before_validation :compute_hash

    validates_presence_of :name, :on => :create, :message => "Can't be blank."
    validates_presence_of :file, :on => :create, :message => "Can't be blank."
    validate :uniqueness_of_md5hash, :on => :create

    attr_accessible :file
    mount_uploader :file, FileUploader

    before_save :update_file_info


    def self.search(params)
        tire.search :load => true, :page => params[:page], :per_page => 10 do
            query { string params[:query], :default_operator => "AND"} if params[:query].present?
            highlight :name

            filter :term, :author => params[:author] if params[:author].present?
            # sort { by :published_on, "desc" } if params[:query].blank?

            facet 'authors' do
                terms :author
            end
        end
    end



    def to_indexed_json
        to_json(:methods => [:attachment])
    end

    def attachment
        if file.present?
            # path_to_file = Rails.root + '/public/uploads/' + self.class.name.downcase + '/file/' + self.id
            path_to_file = Rails.root.to_s + '/public' + file_url.to_s
            # binding.pry
          # path_to_pdf = "/Volumes/Calvin/sample_pdfs/#{filename}.pdf"
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
