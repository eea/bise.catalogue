ActiveAdmin.register ProtectedArea do
  menu priority: 4, parent: 'Content'
  config.comments = false

  filter :source_db
  filter :name
  filter :code
  filter :iucnat
  filter :uri
  filter :name
  filter :designation_year
  filter :nuts_code
  filter :area
  filter :length
  filter :long
  filter :lat

  index do
    selectable_column
    id_column
    column :name
    actions
  end
end

