ActiveAdmin.register ProtectedArea do
  menu priority: 4, parent: 'Content'
  config.comments = false

  # filter :valid_name, as: :select

  index do
    selectable_column
    id_column
    column :name
    actions
  end
end

