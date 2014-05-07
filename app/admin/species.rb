ActiveAdmin.register Species do
  menu priority: 5
  config.comments = false

  # filter :valid_name, as: :select

  index do
    selectable_column
    id_column
    column :scientific_name
    column :binomial_name
    column :genus
    # column :species_group
    column :valid_name, as: :boolean do |v|
      if (v == 't')
        status_tag('Yes', :ok)
      else
        status_tag('No', :ok, class: 'errored')
      end
    end

    # column :site
    actions
  end
end

