SmtRails.configure do |config|

    # change extension of mustache templates
    config.template_extension = 'mustache'

    # change name of key for rendering in ActionView mustache template
    config.action_view_key    = 'obj'

    # change templates namespace in javascript
    config.template_namespace = 'SMT'

    # templates dir
    config.template_base_path = Rails.root.join("app", "templates")

end
