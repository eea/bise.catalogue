ActiveAdmin.register Link do
  menu priority: 4
  config.comments = false

  scope :unapproved
  scope :approved

  index do
    selectable_column
    id_column
    column :title
    column :site
    actions
  end
end

