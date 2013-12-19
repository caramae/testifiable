class DatapointsController < ApplicationController
  before_action :set_datapoint, only: [:show, :edit, :update, :destroy]
  before_filter :signed_in?
  before_filter :authorized?, only: [:index]

  # GET /datapoints
  # GET /datapoints.json
  def index
    @datapoints = Datapoint.all
    respond_to do |format|
      format.html
      format.csv { send_data @datapoints.to_csv }
      format.xls
    end
  end

  # GET /datapoints/1
  # GET /datapoints/1.json
  def show
  end

  # GET /datapoints/new
  def new
    if !params[:experiment_id].blank?
      @datapoint = Datapoint.new
      @datapoint.user_id = @current_user.id
      @datapoint.experiment_id = params[:experiment_id].to_i
      @user = User.find(session[:user_id].to_i)

      @experiment = Experiment.find(@datapoint.experiment_id)
    else
      redirect_to @current_user, notice: 'Please an experiment in which you are enrolled.'
    end
  end

  def import
    Datapoint.import(params[:file])
    redirect_to root_url, notice: "Datapoints imported."
  end

  # GET /datapoints/1/edit
  def edit
  end

  # POST /datapoints
  # POST /datapoints.json
  def create
    @datapoint = Datapoint.new(datapoint_params)
    @experiment = Experiment.find(@datapoint.experiment_id)
    respond_to do |format|
      if @datapoint.save
        enroll = Enroll.where('experiment_id=? and user_id=?', @datapoint.experiment_id, @datapoint.user_id)[0]
        enroll.randomize = 0
        enroll.save()
        format.html { redirect_to @experiment, notice: 'Datapoint was successfully created.' }
        format.json { render action: 'show', status: :created, location: @datapoint }
      else
        format.html { render action: 'new' }
        format.json { render json: @datapoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /datapoints/1
  # PATCH/PUT /datapoints/1.json
  def update
    @experiment = Experiment.find(@datapoint.experiment_id)
    respond_to do |format|
      if @datapoint.update(datapoint_params)
        format.html { redirect_to @experiment, notice: 'Datapoint was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @datapoint.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datapoints/1
  # DELETE /datapoints/1.json
  def destroy
    @datapoint.destroy
    respond_to do |format|
      format.html { redirect_to datapoints_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_datapoint
      @datapoint = Datapoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def datapoint_params
      params.require(:datapoint).permit(:experiment_id, :user_id, :value)
    end
end
