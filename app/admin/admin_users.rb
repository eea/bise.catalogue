ActiveAdmin.register AdminUser do
  menu parent: 'Others'
  config.comments = false

  form do |f|
    f.inputs 'Admin User Details' do
      f.input :email
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :email
    actions
  end
end

