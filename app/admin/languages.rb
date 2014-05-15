ActiveAdmin.register Language do
  menu parent: 'Others'
  config.comments = false

  form do |f|
    f.inputs 'Language Details' do
      f.input :name
    end
    f.actions
  end

  filter :name

  index do
    selectable_column
    id_column
    column :name
    column :code
    actions
  end
end

