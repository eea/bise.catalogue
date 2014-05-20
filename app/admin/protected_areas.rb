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

  show title: :name do |site|
    attributes_table do
      row :id
      row :name
      row :source_db
      row :code
      row :iucnat
      row :uri
      row :name
      row :designation_year
      row :nuts_code
      row :area
      row :length
      row :long
      row :lat
      row :created_at
      row :updated_at

    end
    panel 'Countries' do
      table_for site.countries.order(:name).reverse do
        column :name
      end
    end
    panel 'Species' do
      table_for site.species.order(:binomial_name).reverse do
        column :binomial_name
      end
    end
  end
end

