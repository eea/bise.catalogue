ActiveAdmin.register ProtectedArea do
  menu priority: 7
  config.comments = false

  # filter :valid_name, as: :select

  index do
    selectable_column
    id_column
    column :name
    actions
  end
end

