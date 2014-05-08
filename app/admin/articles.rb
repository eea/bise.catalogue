ActiveAdmin.register Article do
  menu priority: 2
  # permit_params :title,
  #               :question_date,
  #               :created_at, answers_attributes: [:user_id, :content]
  config.comments = false

  scope :unapproved
  scope :approved

  index do
    selectable_column
    id_column
    column :title
    column :site
    actions
  end

  # filter :title
  # filter :created_at

  # form do |f|
  #   f.inputs 'Question Details' do
  #     f.input :title
  #     f.input :question_date, as: :date
  #     # f.input :created_at, as: :date
  #     f.has_many :answers do |a|
  #       a.input :user
  #       a.input :content
  #     end
  #     # f.fields_for :answers do |answer|
  #     #   answer.input :content
  #     # end
  #   end
  #   f.actions
  # end


  # show title: :title do |question|
  #   attributes_table do
  #     row :id
  #     row :title
  #     row :created_at
  #     row :updated_at

  #   end
  #   panel 'Ansers' do
  #     table_for question.answers.order(:created_at).reverse do
  #       column :user
  #       column :content
  #       column :created_at
  #       # ...
  #     end

  #   end
  # end

end

