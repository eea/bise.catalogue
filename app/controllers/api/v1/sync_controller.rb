require 'sanitize'

class Api::V1::SyncController < ApplicationController

  skip_before_action :verify_authenticity_token
  skip_before_filter :protect_from_forgery
  # rescue_from StandardError, with: :register_exceptions
  # rescue_from ActiveRecord::RecordInvalid, with: :register_exceptions
  # rescue_from ActiveRecord::RecordNotSaved, with: :register_exceptions


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
    logger.info ''
    logger.info '::::: SYNC PARAMS => '
    logger.info params
    logger.info ''
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
        respond_with_unprocessable @article
      end
    when 'document'
      @document = Document.new(params[:document])
      if @document.save
        render json: @document, status: :created, location: @document
      else
        respond_with_unprocessable @document
      end
    when 'link'
      @link = Link.new(params[:link])
      if @link.save
        render json: @link, status: :created, location: @link
      else
        respond_with_unprocessable @link
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
          respond_with_unprocessable @article
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
          respond_with_unprocessable @document
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
          respond_with_unprocessable @link
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
    render json: { error: msg }, status: :unprocessable_entity
    return
  end

  private

  def respond_with_unprocessable(model)
    logger.debug { ":::::::::::::::::::::::::::::::::::::::::::::::::::::" }
    logger.debug { ":::::::::::::::UNPROCESSAB:::::::::::::::::::::::::::" }

    model.errors.each do |k, v|
      UnprocessedObject.create!({ model: model.class.name,
                                    http_method: request.method,
                                    field: k,
                                    message: v,
                                    ip: request.ip,
                                    params: params.to_s })
    end
    render json: model.errors, status: :unprocessable_entity
  end

  # def register_exceptions(exception)
  #   # binding.remote_pry
  #   logger.debug { ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::" }
  #   logger.debug { "::       REGISTERIN EXCEPTION IN DATABASE                " }
  #   logger.debug { exception }
  #   logger.debug { ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::" }
  #   # exception.record.new_record? ? ...
  #   # respond_to do |type|
  #   #   type.html { render template: "errors/error_404", status: 404 }
  #   #   type.all  { render nothing: true, status: 404 }
  #   # end
  #   true
  # end

end
