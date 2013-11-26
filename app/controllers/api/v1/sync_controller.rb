require 'sanitize'

module Api
  module V1

    class SyncController < ApplicationController

      # We overwrite as_json method to create custom mappings
      # class EcosystemAssessment < ::EcosystemAssessment
      #     def as_json(options={})
      #         super.merge(released_on: released_at.to_date)
      #     end
      # end

      respond_to :json

      after_filter :set_access_control_headers

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
      #   link[description]:   text/html
      #
      def create
        case params[:resource_type]
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
        case params[:resource_type]
        when 'article'
          @article = Article.find(params[:id])
          if @article.update_attributes(params[:article])
            render json: @article, status: :created, location: @article
          else
            render json: @article.errors, status: :unprocessable_entity
          end
        when 'document'
          @document = Document.find(params[:id])
          if @document.update_attributes(params[:document])
            render json: @document, status: :created, location: @document
          else
            render json: @document.errors, status: :unprocessable_entity
          end
        when 'link'
          @link = Link.find(params[:id])
          if @link.update_attributes(params[:link])
            render json: @link, status: :created, location: @link
          else
            render json: @link.errors, status: :unprocessable_entity
          end
        else
          return_error('resource_type not especified on update.')
        end
      end

      def delete
        p ":: DELETE"
        case params[:resource_type]
        when 'article'
          @article = Article.find(params[:id])
          @article.destroy
          respond_to do |format|
            format.json { head :no_content }
          end
        when 'document'
          @document = Document.find(params[:id])
          @document.destroy
          respond_to do |format|
            format.json { head :no_content }
          end
        when 'link'
          @link = Link.find(params[:id])
          @link.destroy
          respond_to do |format|
            format.json { head :no_content }
          end
        else
          return_error('resource_type not especified.')
        end
      end

      def return_error(msg)
        render json: { error: msg }
      end

    end

  end
end
