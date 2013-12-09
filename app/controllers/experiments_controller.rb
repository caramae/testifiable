class ExperimentsController < ApplicationController
  before_action :set_experiment, only: [:show, :edit, :update, :destroy, :enroll], except: [:randomize]
  before_filter :signed_in?, except: [:index, :show]

  
  # GET /experiments
  # GET /experiments.json
  def index
    if !session[:user_id].blank?
      @current_user = User.find(session[:user_id].to_i)
    end
    @experiments = Experiment.all
  end

  def enroll
    if session[:user_id]
      Enroll.create(experiment_id:@experiment.id, user_id:session[:user_id].to_i, randomize:0)
      respond_to do |format|
        format.html { redirect_to experiments_path, notice: 'Successfully Enrolled in experiment!' }
        format.json { render action: 'index', status: :created, location: experiments_path }
      end
    else
      respond_to do |format|
        format.html { redirect_to experiments_path, notice: 'Please login to enroll.' }
        format.json { render action: 'index', status: :created, location: experiments_path }
      end
    end
  end

  def randomize
    if session[:user_id]
      if !params[:experiment_id].blank?
        @experiment = Experiment.find(params[:experiment_id].to_i)
        @user = User.find(session[:user_id].to_i)
        enrolled = Enroll.where('experiment_id=? and user_id=?', @experiment.id, @user.id)[0]
        enrolled.randomize = Random.rand(1..2)
        enrolled.save()
        respond_to do |format|
          format.html { redirect_to @user, notice: 'Successfully Randomized to an action!' }
          format.json { render controller:'users', action: 'show', status: :created, location: @user }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to login_path, notice: 'Please login to enroll.' }
      end
    end
  end

  # GET /experiments/1
  # GET /experiments/1.json
  def show
    if !session[:user_id].blank?
      @current_user = User.find(session[:user_id].to_i)
    end
  end

  # GET /experiments/new
  def new
    @experiment = Experiment.new
  end

  # GET /experiments/1/edit
  def edit
  end

  # POST /experiments
  # POST /experiments.json
  def create
    @experiment = Experiment.new(experiment_params)
    @experiment.author = session[:user_id]
    @experiment.action = @experiment.action.downcase
    @experiment.outcome = @experiment.outcome.downcase
    @experiment.control = @experiment.control.downcase
    @experiment.unit = @experiment.unit.downcase

    respond_to do |format|
      if @experiment.save
        format.html { redirect_to @experiment, notice: 'Experiment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @experiment }
      else
        format.html { render action: 'new' }
        format.json { render json: @experiment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /experiments/1
  # PATCH/PUT /experiments/1.json
  def update
    respond_to do |format|
      if @experiment.update(experiment_params)
        format.html { redirect_to @experiment, notice: 'Experiment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @experiment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experiments/1
  # DELETE /experiments/1.json
  def destroy
    @experiment.destroy
    respond_to do |format|
      format.html { redirect_to experiments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experiment
      @experiment = Experiment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experiment_params
      params.require(:experiment).permit(:action, :control, :outcome, :unit)
    end
end
