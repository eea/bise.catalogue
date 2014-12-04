class Biseadmin::TargetsController < ApplicationController

  before_filter :authenticate_user!

  def index
    @targets = Target.all

    respond_to do |format|
      format.html
      format.json { render json: @targets }
    end
  end

  def new
    @target = Target.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @target }
    end
  end

  def show
    @target = Target.find(params[:id])
  end

  def edit
    @target = Target.find(params[:id])
  end

  def create
    @target = Target.new(target_params)

    respond_to do |format|
      if @target.save
        format.html { redirect_to biseadmin_target_path(@target), notice: 'Target was successfully created.' }
        format.json { render json: @target, status: :created, location: @target }
      else
        format.html { render action: "new" }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @target = Target.find(params[:id])

    respond_to do |format|
      if @target.update_attributes(target_params)
        format.html { redirect_to biseadmin_targets_path, notice: 'Target was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @target.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @target = Target.find(params[:id])
    @target.destroy
    msg = (!@target.errors.empty?) ? @target.errors[:base].try(:first) : false
    respond_to do |format|
      format.html { redirect_to biseadmin_targets_url, alert: msg }
      format.json { head :no_content }
    end
  end

  private

  def target_params
    params.require(:target).permit(:title, :short_desc)
  end
end
