class ExperimentsController < ApplicationController
  before_action :set_experiment, only: [:show, :edit, :update, :destroy, :enroll, :unenroll, :reenroll]
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
      Enroll.create(experiment_id:@experiment.id, user_id:session[:user_id].to_i, status:Random.rand(1..2), is_active:true, end_time: @experiment.get_ending_time)
      #flash[:modal] = "Successfully enrolled in experiment.\nYour assigned action is: " + (status==1 ? @experiment.action : @experiment.control) + "."
      #if @experiment.outcomes.count {|outcome| outcome.has_init_value && @datapoint.init_value.nil?} > 0
      #  flash[:modal] = flash[:modal] + "\nPlease record initial values before performing your action."
      #end
      respond_to do |format|
        format.html { redirect_to current_user }
        format.json { render action: 'index', status: :created, location: current_user }
      end
    else
      respond_to do |format|
        format.html { redirect_to experiments_path, notice: 'Please login to enroll.' }
        format.json { render action: 'index', status: :created, location: experiments_path }
      end
    end
  end

  def reenroll
    enroll = Enroll.where('experiment_id=? and user_id=?', @experiment.id, session[:user_id].to_i)[0]
    enroll.is_active = true
    enroll.status = Random.rand(1..2)
    enroll.end_time = @experiment.get_ending_time
    enroll.save()
    respond_to do |format|
      format.html { redirect_to current_user, notice: 'Successfully reenrolled.' }
      format.json { render action: 'index', status: :created, location: current_user }
    end
  end

  def unenroll
    Enroll.where('experiment_id=? and user_id=?', @experiment.id, session[:user_id].to_i)[0].destroy!
    respond_to do |format|
      format.html { redirect_to current_user, notice: 'Successfully unenrolled.' }
      format.json { render action: 'index', status: :created, location: current_user }
    end
  end

  # GET /experiments/1
  # GET /experiments/1.json
  def show
    if !session[:user_id].blank?
      @current_user = User.find(session[:user_id].to_i)
    end

    @chart = LazyHighCharts::HighChart.new('graph') do |f|
      f.title({ :text=>"Analysis chart"})
      f.options[:xAxis][:categories] = [@experiment.action.humanize, @experiment.control.humanize]
      f.labels(:items=>[:html=>"Compliance", :style=>{:left=>"40px", :top=>"8px", :color=>"black"} ])      
      f.series(:type=> 'column',:name=> "Assigned to " + @experiment.action,:data=> [@experiment.get_avg_val(1, true), @experiment.get_avg_val(1, false)]) #@experiment.datapoints
      f.series(:type=> 'column',:name=> "Assigned to " + @experiment.control,:data=> [@experiment.get_avg_val(2, false), @experiment.get_avg_val(2, true)])
      #f.series(:type=> 'spline',:name=> 'Average', :data=> [3, 2.67])
      #f.series(:type=> 'pie',:name=> 'Total consumption', 
      #  :data=> [
      #    {:name=> 'Jane', :y=> 13, :color=> 'red'}, 
      #    {:name=> 'John', :y=> 23,:color=> 'green'},
      #    {:name=> 'Joe', :y=> 19,:color=> 'blue'}
      #  ],
      #  :center=> [100, 80], :size=> 100, :showInLegend=> false)
    end
  end

  # GET /experiments/new
  def new
    @experiment = Experiment.new
    @experiment.outcomes.build
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
    @experiment.control = @experiment.control.downcase

    respond_to do |format|
      if @experiment.save
        @pending_experiment = PendingExperiment.new(pending_experiment_params)
        @pending_experiment.author = session[:user_id]
        @pending_experiment.action = @experiment.action.downcase
        @pending_experiment.control = @experiment.control.downcase
        @pending_experiment.experiment_id = @experiment.id

        @pending_experiment.save

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
      params.require(:experiment).permit(:action, :control, :author, :prereqs, :is_public, :timeframe, :timeinterval, :initvalue, :must_email, :timeframe_units, :category, outcomes_attributes: [:id, :name, :unit, :has_init_value, :type])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def pending_experiment_params
      params.require(:experiment).permit(:action, :control, :author, :prereqs, :is_public, :timeframe, :timeinterval, :initvalue, :must_email, :timeframe_units, :category)
    end
end
