class Biseadmin::StrategyActionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    authorize! :admin, StrategyAction
    @actions = StrategyAction.all

    respond_to do |format|
      format.html
      format.json { render json: @actions }
    end
  end

  def new
    @action = StrategyAction.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @action }
    end
  end

  def show
    @action = StrategyAction.find(params[:id])
  end

  def edit
    @action = StrategyAction.find(params[:id])
  end

  def create
    @action = StrategyAction.new(action_params)
    respond_to do |format|
      if @action.save
        format.html { redirect_to biseadmin_target_path(@action.target), notice: 'StrategyAction was successfully created.' }
        format.json { render json: @action, status: :created, location: @action }
      else
        format.html { render action: "new" }
        format.json { render json: @action.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @action = StrategyAction.find(params[:id])

    respond_to do |format|
      if @action.update_attributes(action_params)
        format.html { redirect_to biseadmin_target_path(@action.target), notice: 'StrategyAction was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @action.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @action = StrategyAction.find(params[:id])
    target = @action.target
    @action.destroy

    respond_to do |format|
      format.html { redirect_to biseadmin_target_path(target) }
      format.json { head :no_content }
    end
  end

  private

  def action_params
    params.require(:strategy_action).permit(:title, :short_desc, :target_id)
  end
end
