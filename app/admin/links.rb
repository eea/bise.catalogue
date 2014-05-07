ActiveAdmin.register Link do
  menu priority: 4
  config.comments = false

  index do
    selectable_column
    id_column
    column :title
    column :site
    actions
  end
end

