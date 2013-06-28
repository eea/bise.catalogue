module Api
    module V1
        class EcosystemAssessmentsController < ApplicationController

            # We overwrite as_json method to create custom mappings
            # class EcosystemAssessment < ::EcosystemAssessment
            #     def as_json(options={})
            #         super.merge(:released_on => released_at.to_date)
            #     end
            # end

            respond_to :json

            def index
                rows = EcosystemAssessment.find(:all, :order => "id desc", :limit => 3)
                res = {
                    :count => EcosystemAssessment.all.size,
                    :last_3_assessment => rows
                }
                respond_with res
              # respond_with EcosystemAssessment.all.size
            end

            def show
              respond_with EcosystemAssessment.find(params[:id])
            end

            def create
                errors = Array.new
                puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
                params.each do |p|
                    puts ":: param => #{p.to_s}"
                end
                puts "::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
                # if params.size > 0
                #     respond_with EcosystemAssessment.new
                # else
                #     respond_with errors.to_json
                # end
                respond_with EcosystemAssessment.create(params[:ecosystem_assessment])
            end

            def update
              respond_with EcosystemAssessment.update(params[:id], params[:ecosystem_assessments])
            end

            def destroy
              respond_with EcosystemAssessment.destroy(params[:id])
            end
        end
    end
end

