ActiveAdmin.register Document do
  menu priority: 2, parent: 'Content'
  config.comments = false

  scope :unapproved
  scope :approved

  filter :site

  index do
    selectable_column
    id_column
    column :title
    column :site
    actions
  end
end

