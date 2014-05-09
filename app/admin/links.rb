ActiveAdmin.register Link do
  menu priority: 3, parent: 'Content'
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

