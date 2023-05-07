class StorageUnitsController < ApplicationController
  before_action :set_storage_unit, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  # GET /storage_units
  def index
    if params[:search]
      @storage_units = policy_scope(StorageUnit).where("name ILIKE ?", "%#{params[:search]}%").order(:id)
    else
      @storage_units = policy_scope(StorageUnit).all.order(:id)
    end

    @pagy, @storage_units = pagy(@storage_units.sort_by_params(params[:sort], sort_direction), items: 50)
  end

  # GET /storage_units/1
  def show
  end

  # GET /storage_units/new
  def new
    @storage_unit = StorageUnit.new

    authorize @storage_unit
  end

  # GET /storage_units/1/edit
  def edit
  end

  # POST /storage_units
  def create
    @storage_unit = StorageUnit.new(permitted_attributes(StorageUnit))
    @storage_unit.user ||= current_user

    authorize @storage_unit

    respond_to do |format|
      if @storage_unit.save
        format.html { redirect_to :storage_units, notice: "Storage unit was successfully created." }
        format.json { render :show, status: :created, location: @storage_unit }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @storage_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /storage_units/1
  def update
    respond_to do |format|
      if @storage_unit.update(permitted_attributes(@storage_unit))
        format.html { redirect_to :storage_units, notice: "Storage unit was successfully updated." }
        format.json { render :show, status: :ok, location: @storage_unit }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @storage_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /storage_units/1
  def destroy
    @storage_unit.destroy
    respond_to do |format|
      format.html { redirect_to :storage_units, notice: "Storage unit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_storage_unit
    @storage_unit = StorageUnit.find(params[:id])

    authorize @storage_unit
  rescue ActiveRecord::RecordNotFound
    redirect_to storage_units_path, notice: "Not found"
  end
end
