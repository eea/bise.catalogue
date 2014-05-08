ActiveAdmin.register KeywordContainer do
  config.comments = false

  index do
    selectable_column
    id_column
    column :title
    actions
  end

  form do |f|
    f.inputs 'Keyword Container Details' do
      f.input :title
      f.has_many :keywords do |a|
        a.input :name
      end
    end
    f.actions
  end

  show title: :title do |kc|
    attributes_table do
      row :id
      row :title
      row :created_at
    end
    panel 'Keywords' do
      table_for kc.keywords.order(:name) do
        column :id
        column :name
      end

    end
  end
end

