# Article is a model for saving articles in the catalogue.
# It should contain at least a title, a content and a user.

class Article < ActiveRecord::Base

    include Tire::Model::Search
    include Tire::Model::Callbacks

    attr_accessible :title
    attr_accessible :content
    attr_accessible :author
    attr_accessible :source_url
    attr_accessible :published_on

    validates_presence_of :title, :on => :create, :message => "can't be blank"

    mapping do
        # :analyzer => 'snowball'
        indexes :id,           :index    => :not_analyzed
        indexes :title,        :type => 'string', :analyzer => 'snowball', :tokenizer => 'nGram' , :boost => 100
        indexes :content,      :analyzer => 'snowball'
        # indexes :content_size, :as       => 'content.size'
        indexes :author,       :analyzer => 'snowball'
        indexes :published_on, :type => 'date' #, :include_in_all => false
    end

    def self.search(params)

        date_init = nil
        date_end = nil

        if params[:published_on].present?
            year = params[:published_on].to_i
            logger.debug ':: year => ' + year.to_s
            date_init = DateTime.new(year, 1, 1)
            date_end = DateTime.new(year, 12, 31)
        end

        # :load => true,
        tire.search :page => params[:page], :per_page => 10 do

            query { string params[:query], :default_operator => "AND"} if params[:query].present?
            highlight :title

            filter :term, :author => params[:author] if params[:author].present?
            filter :range, :published_on => { :gte => date_init , :lt => date_end } if params[:published_on].present?

            sort { by :published_on, "desc" } if params[:query].blank?

            facet 'authors' do
                terms :author
            end

            facet('timeline') do
                date :published_on, :interval => 'year'
            end

        end

    end

end
