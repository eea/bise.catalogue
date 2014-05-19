ActiveAdmin.register CatalogueSearch do
  menu priority: 3
  actions :all, except: [:new]
  config.comments = false

  filter :query

  index do
    selectable_column
    id_column
    column :query
    column :created_at
    actions
  end

end

