class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authorized?, except: [:new, :create, :show, :edit]
  
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @current_user ||= User.find(session[:user_id]) if session[:user_id]

    @enrolled_experiments = @user.enrolled_experiments.order('id DESC')
    @managed_experiments = @user.managed_experiments.order('id DESC')
    @recommended_experiments = Experiment.where('id not in (?)', @enrolled_experiments.select('id')).order('id DESC')
  end

  # GET /users/new
  def new
    unless current_user.nil?
  		redirect_to user_path(current_user)
  	end
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        UserMailer.welcome_email(@user).deliver
        
        @adminUser = User.find(User.minimum(:id))
        @adminUser.is_admin = true
        @adminUser.save();
        session[:user_id] = @user.id
        format.html { redirect_to user_path(@user) }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_admin)
    end
end
