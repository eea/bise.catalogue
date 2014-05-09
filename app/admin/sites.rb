ActiveAdmin.register Site do
  menu parent: 'Others'
  config.comments = false

  form do |f|
    f.inputs 'Site Details' do
      f.input :name
      f.input :auth_token
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :auth_token
    actions
  end
end

