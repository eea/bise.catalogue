class Biseadmin::UsersController < ApplicationController

  before_filter :authenticate_user!

  def index
  end

  def edit
    @user = User.find(params[:id])
    @user.update_library_roles()
  end

  def update
    @user = User.find(params[:id])
    respond_to do |format|
      # if @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
      if @user.update_attributes(library_roles_params)
        format.html { redirect_to biseadmin_users_path, notice: 'Roles successfully applied.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def library_roles_params
    params.require(:user).permit(library_roles_attributes: [ :site_id, :allowed])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) { |u|
      u.permit(library_roles_attributes: [:site_id, :allowed])
    }
  end
end

