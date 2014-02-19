class AdminPanelsController < ApplicationController
  before_action :set_admin_panel, only: [:show, :edit, :update, :destroy]

  # GET /admin_panels
  # GET /admin_panels.json
  def index
     experiments = Experiment.select(:id).where(pend_status: [0,1])
     @admin_panels = PendingExperiment.where(experiment_id: experiments)
  end

  # GET /admin_panels/1
  # GET /admin_panels/1.json
  def show
  end

  # GET /admin_panels/new
  def new
    @admin_panel = AdminPanel.new
  end

  # GET /admin_panels/1/edit
  def edit
  end

  # POST /admin_panels
  # POST /admin_panels.json
  def create
    @admin_panel = AdminPanel.new(admin_panel_params)

    respond_to do |format|
      if @admin_panel.save
        format.html { redirect_to @admin_panel, notice: 'Admin panel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @admin_panel }
      else
        format.html { render action: 'new' }
        format.json { render json: @admin_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin_panels/1
  # PATCH/PUT /admin_panels/1.json
  def update
    respond_to do |format|
      if @admin_panel.update(admin_panel_params)
        format.html { redirect_to @admin_panel, notice: 'Admin panel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @admin_panel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin_panels/1
  # DELETE /admin_panels/1.json
  def destroy
    @admin_panel.destroy
    respond_to do |format|
      format.html { redirect_to admin_panels_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_panel
      @admin_panel = AdminPanel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_panel_params
      params[:admin_panel]
    end
end
