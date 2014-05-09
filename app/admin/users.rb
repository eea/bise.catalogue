ActiveAdmin.register User do
  menu parent: 'Others'
  config.comments = false

  form do |f|
    f.inputs 'User Details' do
      f.input :login
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :login
    actions
  end
end

