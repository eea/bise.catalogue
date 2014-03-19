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


      def bise_search
        q = clean_param(params[:query])

        date_init = nil
        date_end = nil
        if params[:published_on].present?
          date_init = DateTime.new(params[:published_on].to_i, 1, 1)
          date_end = DateTime.new(params[:published_on].to_i, 12, 31)
        end

        indexes = params[:indexes]
        if indexes == "all"
          indexes = [
            'articles',
            'documents',
            'links'
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

          source_db = params[:source_db] if params[:source_db].present?
          author    = params[:author] if params[:author].present?
          countries = params[:countries].split(/\//) if params[:countries].present?
          languages = params[:languages].split(/\//) if params[:languages].present?
          biogeo    = params[:biographical_region] if params[:biographical_region].present?

          species_group  = params[:species_group] if params[:species_group].present?
          genus          = params[:genus] if params[:genus].present?

          search_filter = []
          search_filter << { term: { approved: true }}
          search_filter << { term: { 'site.name' => 'BISE' }}
          search_filter << { term: { source_db: params[:source_db] }} if params[:source_db].present?
          search_filter << { term: { author: params[:author] }} if params[:author].present?
          search_filter << { term: { 'countries.name' => params[:countries].split(/\//) }} if params[:countries].present?
          search_filter << { term: { 'languages.name' => params[:languages].split(/\//) }} if params[:languages].present?
          search_filter << { term: { biographical_region: params[:biographical_region] }} if params[:biographical_region].present?
          search_filter << { range: { published_on: { gte: date_init , lt: date_end }}} if params[:published_on].present?

          @rows = Tire.search indexes, load: false, from: from, size: per do
            query do
              boolean do
                # SITE
                should   { string 'site.name: BISE' }

                # Article & Documents titles
                should   { string 'title:'                     + q }
                should   { string 'english_title:'             + q }
                should   { string 'description:'               + q }
                should   { string 'content:'                   + q }

                should   { string 'attachment:'                + q }

                # AUTHOR
                should   { string 'ngram_author:'              + q }

                # Countries & Languages
                should   { string 'countries.ngram_name:'      + q }
                should   { string 'languages.ngram_name:'      + q }

                # Tags
                should   { string 'tags.ngram_name:'           + q }

                # Biographical Region
                should   { string 'biographical_region_ngram:' + q }

                # Protected Area name
                should   { string 'name:'                      + q }
                should   { string 'habitats.name:'             + q }
                should   { string 'habitats.code:'             + q }
                should   { string 'biogeo_regions.name:'       + q }
                should   { string 'biogeo_regions.code:'       + q }
              end
            end

            filter :bool, must: { term: { approved: true } }
            filter :term, 'site.name' => 'BISE'
            filter :term, source_db: source_db unless source_db.nil?
            filter :term, author: author unless author.nil?
            filter :term, 'countries.name' => countries unless countries.nil?
            filter :term, 'languages.name' => languages unless languages.nil?
            filter :term, biographical_region: biogeo unless biogeo.nil?
            filter :range, published_on: { gte: date_init, lt: date_end } unless date_init.nil?

            highlight attachment: { number_of_fragments: 2 }

            facet 'source_db' do
              terms :source_db
              facet_filter :and, search_filter unless search_filter.empty?
            end

            facet 'author' do
              terms :author
              facet_filter :and, search_filter unless search_filter.empty?
            end

            facet 'countries' do
              terms 'countries.name', size: 60
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

            facet 'published_on' do
              date :published_on, interval: 'year'
              facet_filter :and, search_filter unless search_filter.empty?
            end
          end
        else
          @rows = nil
        end
        respond_with render_response(@rows)
      end

      def index
        q = clean_param(params[:query])

        date_init = nil
        date_end = nil
        if params[:published_on].present?
          date_init = DateTime.new(params[:published_on].to_i, 1, 1)
          date_end = DateTime.new(params[:published_on].to_i, 12, 31)
        end

        indexes = params[:indexes]
        if indexes == "all"
          indexes = [
            'articles',
            'documents',
            # 'news',
            'links',
            'protected_areas',
            'habitats',
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

          site      = params[:site] if params[:site].present?
          source_db = params[:source_db] if params[:source_db].present?
          author    = params[:author] if params[:author].present?
          countries = params[:countries].split(/\//) if params[:countries].present?
          languages = params[:languages].split(/\//) if params[:languages].present?
          biogeo    = params[:biographical_region] if params[:biographical_region].present?

          kingdom        = params[:kingdom] if params[:kingdom].present?
          phylum         = params[:phylum] if params[:phylum].present?
          classis        = params[:classis] if params[:classis].present?
          species_group  = params[:species_group] if params[:species_group].present?
          taxonomic_rank = params[:taxonomic_rank] if params[:taxonomic_rank].present?
          genus          = params[:genus] if params[:genus].present?

          search_filter = []
          search_filter << { term: { approved: true }}
          search_filter << { term: { 'site.name' => params[:site] }} if params[:site].present?
          search_filter << { term: { source_db: params[:source_db] }} if params[:source_db].present?
          search_filter << { term: { author: params[:author] }} if params[:author].present?
          search_filter << { term: { 'countries.name' => params[:countries].split(/\//) }} if params[:countries].present?
          search_filter << { term: { 'languages.name' => params[:languages].split(/\//) }} if params[:languages].present?
          search_filter << { term: { biographical_region: params[:biographical_region] }} if params[:biographical_region].present?
          search_filter << { range: { published_on: { gte: date_init , lt: date_end }}} if params[:published_on].present?

          search_filter << { term: { kingdom: kingdom }} if params[:kingdom].present?
          search_filter << { term: { phylum: phylum }} if params[:phylum].present?
          search_filter << { term: { classis: classis }} if params[:classis].present?
          search_filter << { term: { species_group: species_group }} if params[:species_group].present?
          search_filter << { term: { taxonomic_rank: taxonomic_rank }} if params[:taxonomic_rank].present?
          search_filter << { term: { genus: genus }} if params[:genus].present?

          @rows = Tire.search indexes, load: false, from: from, size: per do
            query do
              boolean do
                # Article & Documents titles
                should   { string 'title:'                     + q }
                should   { string 'english_title:'             + q }
                should   { string 'description:'               + q }
                should   { string 'content:'                   + q }

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
                should   { string 'vernacular_names.name:'     + q }
                should   { string 'authorship:'                + q }
                should   { string 'species_group:'             + q }
                should   { string 'taxonomic_rank:'            + q }
                should   { string 'genus:'                     + q }
                should   { string 'kingdom:'                   + q }
                should   { string 'phylum:'                    + q }
                should   { string 'classis:'                   + q }
                should   { string 'synonyms.binomial_name:'    + q }
                should   { string 'synonyms.scientific_name:'  + q }
                should   { string 'protected_areas.code:'      + q }
                should   { string 'protected_areas.name:'      + q }
                # TODO: Add habitats

                # Protected Area name
                should   { string 'name:'                      + q }
                should   { string 'habitats.name:'             + q }
                should   { string 'habitats.code:'             + q }
                should   { string 'biogeo_regions.name:'       + q }
                should   { string 'biogeo_regions.code:'       + q }
              end
            end

            filter :bool, must: { term: { approved: true } }
            filter :term, 'site.name' => site unless site.nil?
            filter :term, source_db: source_db unless source_db.nil?
            filter :term, author: author unless author.nil?
            filter :term, 'countries.name' => countries unless countries.nil?
            filter :term, 'languages.name' => languages unless languages.nil?
            filter :term, biographical_region: biogeo unless biogeo.nil?
            filter :range, published_on: { gte: date_init, lt: date_end } unless date_init.nil?

            filter :term, kingdom: kingdom unless kingdom.nil?
            filter :term, phylum: phylum unless phylum.nil?
            filter :term, classis: classis unless classis.nil?
            filter :term, species_group: species_group unless species_group.nil?
            filter :term, taxonomic_rank: taxonomic_rank unless taxonomic_rank.nil?
            filter :term, genus: genus unless genus.nil?


            highlight attachment: { number_of_fragments: 2 }

            facet 'site' do
              terms 'site.name'
              facet_filter :and, search_filter unless search_filter.empty?
            end

            facet 'source_db' do
              terms :source_db
              facet_filter :and, search_filter unless search_filter.empty?
            end

            facet 'author' do
              terms :author
              facet_filter :and, search_filter unless search_filter.empty?
            end

            facet 'countries' do
              terms 'countries.name', size: 60
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

            facet 'kingdom' do
              terms :kingdom
              facet_filter :and, search_filter  unless search_filter.empty?
            end

            facet 'phylum' do
              terms :phylum
              facet_filter :and, search_filter  unless search_filter.empty?
            end

            facet 'classis' do
              terms :classis
              facet_filter :and, search_filter  unless search_filter.empty?
            end

            facet 'species_group' do
              terms :species_group, size: 15
              facet_filter :and, search_filter  unless search_filter.empty?
            end

            facet 'taxonomic_rank' do
              terms :taxonomic_rank, size: 15
              facet_filter :and, search_filter  unless search_filter.empty?
            end

            facet 'genus' do
              terms :genus, order: 'term'
              facet_filter :and, search_filter  unless search_filter.empty?
            end

            facet 'published_on' do
              date :published_on, interval: 'year'
              facet_filter :and, search_filter unless search_filter.empty?
            end
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

      private

      def clean_param(param)
        (param.nil?) ? nil : Sanitize.clean(param)
      end

      def render_response(rows)
        response = Hash.new
        if rows.nil? || rows.results.nil?
          response['total']   = 0
          response['results'] = []
          response['facets']  = []
        else
          response['total']   = rows.results.total
          response['results'] = rows.results
          response['facets']  = rows.results.facets
        end
        response
      end

    end
  end
end
