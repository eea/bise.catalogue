ActiveAdmin.register Taxonomy do
  menu parent: 'Others'
  config.comments = false

  filter :uri
  filter :code
  filter :name
  filter :level
  filter :parent_id
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    id_column
    column :uri
    column :code
    column :name
    column :level
    column :parent_id
    actions
  end
end

