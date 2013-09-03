class ApplicationController < ActionController::Base

  layout :layout_by_resource

  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end

  protect_from_forgery
  add_breadcrumb :index, :root_path

  after_filter :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = "GET, PUT, POST, DELETE"
    headers["Access-Control-Allow-Headers"] = "Content-Type, X-Requested-With"
    headers['Access-Control-Request-Method'] = '*'
  end

  def layout_by_resource
    if devise_controller?
      "external"
    else
      "application"
    end
  end

end
