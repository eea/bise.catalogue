class Species < ActiveRecord::Base

    include Tire::Model::Search
    include Tire::Model::Callbacks

    attr_accessible :binomial_name
    attr_accessible :eunis_primary_name
    attr_accessible :genus
    attr_accessible :ignore_on_match
    attr_accessible :label
    attr_accessible :name_according_to_ID
    attr_accessible :scientific_name
    attr_accessible :scientific_name_authorship
    attr_accessible :species_code
    attr_accessible :species_group
    attr_accessible :synonym_for
    attr_accessible :taxonomic_rank
    attr_accessible :taxonomy
    attr_accessible :valid_name

    index_name "#{Tire::Model::Search.index_prefix}species"

    mapping do
        indexes :id, :index    => :not_analyzed
        indexes :binomial_name, :analyzer => 'snowball', :boost => 100
        indexes :eunis_primary_name, :analyzer => 'snowball'
        indexes :created_at, :type => 'date'
    end

    def self.search(params)
        tire.search :load => true, :page => params[:page], :per_page => 10 do
            query { string params[:query], :default_operator => "AND"} if params[:query].present?

            # highlight :name, :options => { :tag => '<strong class="highlight">' }

            # filter :term, :author => params[:author] if params[:author].present?

            sort { by :created_at, "desc" } # if params[:query].blank?

            facet('timeline') do
                date :created_at, :interval => 'year'
            end
        end
    end

end
