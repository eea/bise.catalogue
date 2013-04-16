Tire.configure do
    # logger STDERR
    url "http://89.0.1.129:9200"
    # prefix = "#{Rails.application.class.parent_name.downcase}_#{Rails.env.to_s.downcase}_"
    # Tire::Model::Search.index_prefix(prefix)
end

# app_name = Rails.application.class.parent_name.underscore.dasherize
# app_env = Rails.env
# INDEX_NAME = "#{app_name}-#{app_env}"

Tire::Model::Search.index_prefix "#{Rails.application.class.parent_name.downcase}_#{Rails.env.to_s.downcase}_"
