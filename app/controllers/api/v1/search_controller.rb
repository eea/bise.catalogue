module Api
    module V1
        class SearchController < ApplicationController

            # We overwrite as_json method to create custom mappings
            # class EcosystemAssessment < ::EcosystemAssessment
            #     def as_json(options={})
            #         super.merge(:released_on => released_at.to_date)
            #     end
            # end

            respond_to :json

            after_filter :set_access_control_headers

            def set_access_control_headers
                headers['Access-Control-Allow-Origin'] = '*'
                headers['Access-Control-Request-Method'] = '*'
            end

            def index
                puts ":: search#index"
                q = params[:query]
                q = nil if q == ''

                indexes = [
                    'articles',
                    'documents',
                    'news',
                    'links',
                    'protected_areas',
                    'habitats',
                    'species'
                    # ].map { |i| "deployer_catalogue_#{Rails.env.downcase}_#{i}" }
                ].map { |i| "deployer_catalogue_production_#{i}" }

                puts indexes

                # indexes = indexes.map { |i| "catalogue_#{i}_#{Rails.env.downcase}"}
                # if Rails.env.production?
                #     indexes = %w(catalogue_production_articles catalogue_production_documents catalogue_production_species)
                # elsif Rails.env.development?
                #     indexes = %w(catalogue_development_articles catalogue_development_documents catalogue_development_species)
                # end

                if !q.nil?
                    @rows = Tire.search indexes, :laod => true, :page => params[:page], :per_page => 30 do
                        query do
                            boolean do
                                # Article & Documents titles
                                should   { string 'title:' + q }

                                # Species scientifi name
                                should   { string 'scientific_name:' + q }

                                # should   { string 'content:' + params[:query].to_s }
                                # must_not { string 'published:0' }
                            end
                        end
                    end
                else
                    @rows = nil
                end

                # binding.pry

                if @rows and @rows.results
                    respond_with @rows.results
                else
                    result = { :results => 0 }
                    respond_with result
                end
                # # @articles = Article.first
                # respond_to do |format|
                #     format.html
                #     format.json { render :json => @rows.results }
                # end

                # rows = EcosystemAssessment.find(:all, :order => "id desc", :limit => 3)
                # res = {
                #     :count => EcosystemAssessment.all.size,
                #     :last_3_assessment => rows
                # }
                # respond_with res
            end

        end
    end
end

