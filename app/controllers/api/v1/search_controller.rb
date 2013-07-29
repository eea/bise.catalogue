require 'sanitize'

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
        q = params[:query]
        q = Sanitize.clean(q)
        q = nil if q == ''

        indexes = params[:indexes]
        if indexes == "all"
          indexes = [
            'articles',
            'documents',
            # 'news',
            # 'links',
            'protected_areas',
            # 'habitats',
            'species'
          ]
        else
          indexes = [ indexes ]
        end

        indexes = indexes.map do |i|
          if Rails.env.production?
            "catalogue_production_#{i}"
          else
            "catalogue_development_#{i}"
          end
        end

        if !q.nil?

          page = if params[:page].present? then params[:page].to_i else 1 end
          per  = if params[:per_page].present? then params[:per_page].to_i else 10 end
          from = if page == 1 then 0 else (page - 1) * per end

          site      = params[:sites] if params[:sites].present?
          author    = params[:authors] if params[:authors].present?
          countries = params[:countries].split(/\//) if params[:countries].present?
          languages = params[:languages].split(/\//) if params[:languages].present?
          biogeo    = params[:biographical_region] if params[:biographical_region].present?

          search_filter = []
          search_filter << { :term => { 'site.name' => params[:sites] }} if params[:sites].present?
          search_filter << { :term => { :author => params[:authors] }} if params[:authors].present?
          search_filter << { :term => { 'countries.name' => params[:countries].split(/\//) }} if params[:countries].present?
          search_filter << { :term => { 'languages.name' => params[:languages].split(/\//) }} if params[:languages].present?
          search_filter << { :term => { :biographical_region => params[:biographical_region] }} if params[:biographical_region].present?
          # search_filter << { :range=> { :published_on => { :gte => date_init , :lt => date_end }}} if params[:published_on].present?

          @rows = Tire.search indexes, :load => false, :from => from, :size => per do
            query do
              boolean do
                # Article & Documents titles
                should   { string 'title:'                     + q }
                should   { string 'english_title:'             + q }
                should   { string 'description:'               + q }

                should   { string 'attachment:'                + q }

                # AUTHOR
                should   { string 'ngram_author:'              + q }

                # SITE
                should   { string 'site.ngram_name:'           + q }

                # Countries & Languages
                should   { string 'countries.ngram_name:'      + q }
                should   { string 'languages.ngram_name:'      + q }

                # Tags
                should   { string 'tags.ngram_name:'           + q }

                # Biographical Region
                should   { string 'biographical_region_ngram:' + q }

                # Species scientifi name
                should   { string 'scientific_name:'           + q }

                # Protected Area name
                should   { string 'name:'                      + q }

                # must     { string 'author:' + author } unless author.nil?
                # should   { string 'content:' + params[:query].to_s }
                # must_not { string 'published:0' }
              end
            end

            filter :term, 'site.name' => site unless site.nil?
            filter :term, :author => author unless author.nil?
            filter :term, 'countries.name' => countries unless countries.nil?
            filter :term, 'languages.name' => languages unless languages.nil?
            filter :term, :biographical_region => biogeo unless biogeo.nil?
            # filter :range, :published_on => { :gte => date_init , :lt => date_end } if params[:published_on].present?

            facet 'sites' do
              terms 'site.name'
              facet_filter :and, search_filter unless search_filter.empty?
            end

            facet 'authors' do
              terms :author
              facet_filter :and, search_filter unless search_filter.empty?
            end

            facet 'countries' do
              terms 'countries.name'
              facet_filter :and, search_filter unless search_filter.empty?
            end

            facet 'biographical_region' do
              terms :biographical_region
              facet_filter :and, search_filter unless search_filter.empty?
            end

            facet 'languages' do
              terms 'languages.name'
              facet_filter :and, search_filter unless search_filter.empty?
            end

            # facet('timeline') do
            #     date :published_on, :interval => 'year'
            # end
          end
        else
          @rows = nil
        end


        response = Hash.new
        if @rows.nil? or @rows.results.nil?
          response['total'] = 0
          response['results'] = []
          response['facets'] = []
        else
          response['total'] = @rows.results.total
          response['results'] = @rows.results
          response['facets'] = @rows.results.facets
        end
        respond_with response

      end
    end
  end
end
