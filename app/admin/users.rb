ActiveAdmin.register User do
  menu parent: 'Others'
  config.comments = false

  form do |f|
    f.inputs 'User Details' do
      f.input :login
      f.input :email
      f.input :role_admin
      f.input :role_validator
      f.input :role_author
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :login
    column :email
    column :role_admin
    column :role_validator
    column :role_author
    actions
  end
end

