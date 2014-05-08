ActiveAdmin.register Target do
  config.comments = false

  form do |f|
    f.inputs 'Target Details' do
      f.input :title
      f.input :short_desc
      f.has_many :actions do |a|
        a.input :title
      end
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :title
    column :short_desc
    actions
  end

  show title: :title do |kc|
    attributes_table do
      row :id
      row :title
      row :short_desc
      row :created_at
      row :updated_at
    end
    panel 'Actions' do
      table_for kc.actions.order(:title) do
        column :id
        column :title
      end

    end
  end
end

