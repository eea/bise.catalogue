class Biseadmin::UnprocessedObjectsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @unprocessed = UnprocessedObject.all.order('created_at DESC')
                                    .paginate(page: params[:page], per_page: 10)
  end

  def show
    @unprocessed = UnprocessedObject.find(params[:id])
  end
end
