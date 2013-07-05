class ApplicationController < ActionController::Base
    protect_from_forgery
    add_breadcrumb :index, :root_path

    after_filter :set_access_control_headers

    def set_access_control_headers
        headers['Access-Control-Allow-Origin'] = "GET, PUT, POST, DELETE"
        headers["Access-Control-Allow-Headers"] = "Content-Type, X-Requested-With"
        headers['Access-Control-Request-Method'] = '*'
    end
end
