require 'yaml'

Tire.configure do
    logger STDERR if Rails.env.downcase == 'development'

    url ES_CONFIG["#{Rails.env.downcase}_url"]

    # prefix = "#{Rails.application.class.parent_name.downcase}_#{Rails.env.to_s.downcase}_"
    # Tire::Model::Search.index_prefix(prefix)
end

Tire::Model::Search.index_prefix "#{Rails.application.class.parent_name.downcase}_#{Rails.env.to_s.downcase}_"
