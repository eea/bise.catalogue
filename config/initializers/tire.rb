Tire.configure do
    logger STDERR
    url "http://localhost:9200"
    # prefix = "#{Rails.application.class.parent_name.downcase}_#{Rails.env.to_s.downcase}_"
    # Tire::Model::Search.index_prefix(prefix)
end


