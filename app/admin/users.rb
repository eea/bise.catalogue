ActiveAdmin.register User do
  menu parent: 'Others'
  config.comments = false

  scope :admins
  scope :approvers
  scope :authors

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

  controller do
    def permitted_params
      params.require(:user).permit(:email, :role_admin, :role_validator, :role_author)
    end
  end
end

