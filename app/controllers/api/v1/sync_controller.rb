require 'sanitize'

module Api
  module V1

    class SyncController < ApplicationController

      skip_before_filter :protect_from_forgery

      # We overwrite as_json method to create custom mappings
      # class EcosystemAssessment < ::EcosystemAssessment
      #     def as_json(options={})
      #         super.merge(released_on: released_at.to_date)
      #     end
      # end

      respond_to :json

      # before_filter :check_auth_token!
      before_filter do |c|
        @params = request.params
        return_error('resource_type not especified.') if @params[:resource_type].nil?

        # resource_type
        @res = request.params[:resource_type]

        # Converts token and language to internal items
        c.check_auth_token!(request.params[:auth_token])
        c.check_languages(request.params)
        params = @params
      end
      after_filter :set_access_control_headers

      def check_auth_token!(token)
        site = Site.where(auth_token: token).first
        if site.nil?
          return_error("auth_token #{token} not valid for any site.")
        else
          @params[@res.to_sym] = @params[@res.to_sym].merge!({ site_id: site.id }).except!(:auth_token)
        end
      end

      def check_languages(params)
        if params[:language].present?
          language = params[:language]
          lang = Language.where(name: language).first
          lang = Language.where(code: language).first if lang.nil?
          if lang.nil?
            return_error("language #{language} not valid.")
          else
            @params[@res.to_sym] = @params[@res.to_sym].merge!({ language_ids: [lang.id] }).except!(:language)
          end
        end
      end

      def set_access_control_headers
        headers['Access-Control-Allow-Origin'] = '*'
        headers['Access-Control-Request-Method'] = '*'
      end


      # TODO: Create webservices for CodeSyntax
      # -------- /api/v1/sync service ---------
      #
      # resource_type:
      #   - article
      #   - document
      #   - link
      #
      # Common fields for resource_types:
      #   title:         string
      #   site:          1 (BISE)
      #   english_title: string
      #   author:        string  i.e.: Jon Arrien
      #   language_ids:
      #   published_on:  string  (dd/mm/yyyy)
      #   source_url:    string
      #   approved:      boolean
      #   approved_at:   date
      #
      # article:
      #   article[content]:       text/html
      #
      # document:
      #   document[file]:          file
      #   document[description]:   text/html
      #
      # link:
      #   link[url]:           string
      #   link[description]:   text
      #
      def create
        case @res
        when 'article'
          @article = Article.new(params[:article])
          if @article.save
            render json: @article, status: :created, location: @article
          else
            render json: @article.errors, status: :unprocessable_entity
          end
        when 'document'
          @document = Document.new(params[:document])
          if @document.save
            render json: @document, status: :created, location: @document
          else
            render json: @document.errors, status: :unprocessable_entity
          end
        when 'link'
          @link = Link.new(params[:link])
          if @link.save
            render json: @link, status: :created, location: @link
          else
            render json: @link.errors, status: :unprocessable_entity
          end
        else
          return_error('resource_type not especified.')
        end
      end

      def update
        case @res
        when 'article'
          @article = Article.where(source_url: params[:article][:source_url]).first
          if @article.nil?
            return_error('source_url not found.')
          else
            if @article.update_attributes(params[:article])
              render json: @article, status: :updated, location: @article
            else
              render json: @article.errors, status: :unprocessable_entity
            end
          end
        when 'document'
          @document = Document.where(source_url: params[:document][:source_url]).first
          if @document.nil?
            return_error('source_url not found.')
          else
            if @document.update_attributes(params[:document])
              render json: @document, status: :updated, location: @document
            else
              render json: @document.errors, status: :unprocessable_entity
            end
          end
        when 'link'
          @link = Link.where(source_url: params[:link][:source_url]).first
          if @link.nil?
            return_error('source_url not found.')
          else
            if @link.update_attributes(params[:link])
              render json: @link, status: :updated, location: @link
            else
              render json: @link.errors, status: :unprocessable_entity
            end
          end
        else
          return_error('resource_type not especified on update.')
        end
      end

      def delete
        case @res
        when 'article'
          @article = Article.where(source_url: params[:article][:source_url]).first
          if @article.nil?
            return_error('source_url not found.')
          else
            @article.destroy
            render json: { success: 'Article has been deleted.' }, status: 200
          end
        when 'document'
          @document = Document.where(source_url: params[:document][:source_url]).first
          if @document.nil?
            return_error('source_url not found.')
          else
            @document.destroy
            render json: { success: 'Document has been deleted.' }, status: 200
          end
        when 'link'
          @link = Link.where(source_url: params[:link][:source_url]).first
          if @link.nil?
            return_error('source_url not found.')
          else
            @link.destroy
            render json: { success: 'Link has been deleted.' }, status: 200
          end
        else
          return_error('resource_type not especified.')
        end
      end

      def return_error(msg)
        render json: { error: msg }
        return
      end

    end
  end
end
