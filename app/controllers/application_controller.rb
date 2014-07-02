class ApplicationController < ActionController::Base

  layout :layout_by_resource

  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render text: exception, status: 500
  end

  # check_authorization :unless => :devise_controller?
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  protect_from_forgery
  # add_breadcrumb :index, :root_path

  after_filter :set_access_control_headers

  def set_access_control_headers
    headers['Access-Control-Allow-Origin'] = 'GET, PUT, POST, DELETE'
    headers['Access-Control-Allow-Headers'] = 'Content-Type, X-Requested-With'
    headers['Access-Control-Request-Method'] = '*'
  end

  def layout_by_resource
    (devise_controller?) ? 'external' : 'application'
  end

  def authenticate_active_admin_user!
    authenticate_admin_user!
    if current_admin_user.nil?
      flash[:alert] = 'Unauthorized Access!'
      redirect_to admin_users_path
    end
  end
end
