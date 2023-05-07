class AccessCodesController < ApplicationController
  before_action :set_access_code, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  # GET /access_codes
  def index
    if params[:search]
      @access_codes = policy_scope(AccessCode).where("name ILIKE ?", "%#{params[:search]}%").order(:id)
    else
      @access_codes = policy_scope(AccessCode).all.order(:id)
    end

    @pagy, @access_codes = pagy(@access_codes.sort_by_params(params[:sort], sort_direction), items: 50)
  end

  # GET /access_codes/1
  def show
  end

  # GET /access_codes/new
  def new
    @access_code = AccessCode.new

    authorize @access_code
  end

  # GET /access_codes/1/edit
  def edit
  end

  # POST /access_codes
  def create
    @storage_unit = StorageUnit.find(params[:storage_unit_id])
    @access_code = @storage_unit.access_codes.new(permitted_attributes(AccessCode))

    authorize @access_code

    respond_to do |format|
      if @access_code.save
        format.html { redirect_to @access_code.storage_unit, notice: "Access code was successfully created." }
        format.json { render :show, status: :created, location: @access_code }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @access_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /access_codes/1
  def update
    respond_to do |format|
      if @access_code.update(permitted_attributes(@access_code))
        format.html { redirect_to :access_codes, notice: "Access code was successfully updated." }
        format.json { render :show, status: :ok, location: @access_code }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @access_code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /access_codes/1
  def destroy
    @access_code.destroy
    respond_to do |format|
      format.html { redirect_to @access_code.storage_unit, notice: "Access code was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_access_code
    @access_code = AccessCode.find(params[:id])

    authorize @access_code
  rescue ActiveRecord::RecordNotFound
    redirect_to storage_unit_path(params[:storage_unit_id]), error: "Access code not found"
  end
end
