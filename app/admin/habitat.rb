ActiveAdmin.register Habitat do
  menu priority: 6, parent: 'Content'
  config.comments = false

  # filter :valid_name, as: :select

  index do
    selectable_column
    id_column
    column :name
    actions
  end
end

