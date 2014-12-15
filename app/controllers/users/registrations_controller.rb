# controllers/users/registrations_controller.rb
class Users::RegistrationsController < Devise::RegistrationsController

  before_filter :configure_permitted_parameters

  def edit
    @user = User.find(params[:id])
    @user.update_library_roles()
    super
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      # if @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
      if @user.update_attributes(account_update_params)
        format.html { redirect_to biseadmin_users_path, notice: 'Roles successfully applied.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  # def sign_up_params
  #   params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, library_roles_attributes: [ :site_id, :allowed])
  # end

  def account_update_params
    params.require(:user).permit(:role_admin, library_roles_attributes: [ :id, :site_id, :allowed])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :heard_how, :email, :password, :password_confirmation, library_roles_attributes: [ :site_id, :allowed])
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :current_password, :role_admin, library_roles_attributes: [ :site_id, :allowed])
    end
  end
end