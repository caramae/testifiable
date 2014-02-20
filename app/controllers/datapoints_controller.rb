require 'matrix'

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

  def analyze
    @datapoints = Datapoint.all
    xarr = Datapoint.pluck(:iv_value)
    xmat = Matrix.columns([Array.new(xarr.length, 1), xarr])

    ymat = Matrix.column_vector(Datapoint.pluck(:value))
    #yarr = Datapoint.pluck(:value)
    #ymat = Matrix.columns([Array.new(yarr.length, 1), yarr])
    #comp = Datapoint.pluck(:compliance)
    #comp.each {|c| c = (c ? 1 : 0)}
    zarr = Datapoint.pluck(:compliance)
    zmat = Matrix.columns([Array.new(zarr.length, 1), zarr])

    beta = (zmat.t * xmat).inv * zmat.t * ymat
    omg = (ymat.column_vectors[0] - xmat.column_vectors[1]*beta[1,0]).to_a
    omega = Matrix.diagonal(*omg)

    xmat = Matrix.column_vector(Datapoint.pluck(:iv_value))
    zmat = Matrix.column_vector(Datapoint.pluck(:compliance))
    p_z = zmat * (zmat.t * zmat).inv * zmat.t
    z2 = (zmat.t * zmat).inv
    xpx = (xmat.t * p_z * xmat).inv
    var = xpx * (xmat.t * zmat * z2 * (zmat.t * omega * zmat) * z2 * zmat.t * xmat) * xpx
    se2 = Math.sqrt(var[0,0])

    #confint1 = beta[1,0] - 1.96*standard_error
    #confint2 = beta[1,0] + 1.96*standard_error

    Datapoint.create(experiment_id:beta[0,0], iv_value:beta[1,0], value:se2)
    respond_to do |format|
      format.html { redirect_to datapoints_path, notice: 'Here are the results!' }
      #format.json { render action: 'index', status: :created, location: experiments_path }
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
      @datapoint.iv_value = @experiment.enrolled_status(@user.id)
    else
      redirect_to @current_user, notice: 'Please an experiment in which you are enrolled.'
    end
  end

  def import
    Datapoint.import(params[:file])
    redirect_to datapoints_url, notice: "Datapoints imported."
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
        if enroll.status == -2 #need to randomize
          enroll.status = Random.rand(1..2)
          enroll.end_time = @experiment.get_ending_time
        elsif @experiment.timeinterval=='-1' #1 trial/participant
          enroll.status = -2
          enroll.is_active = false
        else
          enroll.status = -1
          enroll.next_time = @experiment.get_next_time
          enroll.is_active = false
        end
        enroll.save()

        format.html { redirect_to @experiment }
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
      params.require(:datapoint).permit(:experiment_id, :user_id, :value, :init_value, :iv_value, :compliance, :comment)
    end
end
