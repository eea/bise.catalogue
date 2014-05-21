ActiveAdmin.register CatalogueSearch do
  menu priority: 3
  actions :all, except: [:new]
  config.comments = false

  filter :query

  index do
    selectable_column
    id_column
    column :query
    column :indexes do |ind|
      ind.split(',').each do |i|
        status_tag(i, :ok)
      end unless ind.nil?
    end
    column :countries_list
    column :languages_list
    column :created_at
    actions
  end

end

