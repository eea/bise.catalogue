ActiveAdmin.register Country do
  menu parent: 'Others'
  config.comments = false

  index do
    selectable_column
    id_column
    column :code
    column :name
    column :uri
    actions
  end

  filter :name

  form do |f|
    f.inputs 'Country Details' do
      f.input :name
      f.input :uri
      f.input :code
      # # t.input :eu15, as: :boolean
      # # t.input :eu25, as: :boolean
      # # t.input :eu27, as: :boolean
      # # t.input :eu28, as: :boolean
      # # t.input :eea
      # # t.input :iso_code2
      # # t.input :iso_code3
      # # t.input :iso_n
      # # t.input :iso_2_wcmc
      # # t.input :iso_3_wcmc
      # # t.input :iso_3_wcmc_parent
      # # t.input :areucd
      # # t.input :surface
      # # t.input :population
      # # t.input :capital
    end
    f.actions
  end

end

