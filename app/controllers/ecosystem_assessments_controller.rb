class EcosystemAssessmentsController < ApplicationController

  before_filter :authenticate_user!

  # GET /ecosystem_assessments
  # GET /ecosystem_assessments.json
  def index
    # @ecosystem_assessments = EcosystemAssessment.all
    @ecosystem_assessments = EcosystemAssessment.paginate(page: params[:page], per_page: 30)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ecosystem_assessments }
    end
  end

  # GET /ecosystem_assessments/1
  # GET /ecosystem_assessments/1.json
  def show
    @ecosystem_assessment = EcosystemAssessment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ecosystem_assessment }
    end
  end

  # GET /ecosystem_assessments/new
  # GET /ecosystem_assessments/new.json
  def new
    @ecosystem_assessment = EcosystemAssessment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ecosystem_assessment }
    end
  end

  # GET /ecosystem_assessments/1/edit
  def edit
    @ecosystem_assessment = EcosystemAssessment.find(params[:id])
  end

  # POST /ecosystem_assessments
  # POST /ecosystem_assessments.json
  def create
    @ecosystem_assessment = EcosystemAssessment.new(params[:ecosystem_assessment])

    respond_to do |format|
      if @ecosystem_assessment.save
        format.html { redirect_to @ecosystem_assessment, notice: 'Ecosystem assessment was successfully created.' }
        format.json { render json: @ecosystem_assessment, status: :created, location: @ecosystem_assessment }
      else
        format.html { render action: "new" }
        format.json { render json: @ecosystem_assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ecosystem_assessments/1
  # PUT /ecosystem_assessments/1.json
  def update
    @ecosystem_assessment = EcosystemAssessment.find(params[:id])

    respond_to do |format|
      if @ecosystem_assessment.update_attributes(params[:ecosystem_assessment])
        format.html { redirect_to @ecosystem_assessment, notice: 'Ecosystem assessment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ecosystem_assessment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ecosystem_assessments/1
  # DELETE /ecosystem_assessments/1.json
  def destroy
    @ecosystem_assessment = EcosystemAssessment.find(params[:id])
    @ecosystem_assessment.destroy

    respond_to do |format|
      format.html { redirect_to ecosystem_assessments_url }
      format.json { head :no_content }
    end
  end
end
