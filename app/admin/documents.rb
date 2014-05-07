ActiveAdmin.register Document do
  menu priority: 3
  config.comments = false

  index do
    selectable_column
    id_column
    column :title
    column :site
    actions
  end
end

