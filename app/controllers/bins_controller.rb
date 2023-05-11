class BinsController < ApplicationController
  before_action :set_storage_unit
  before_action :set_bin, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  # GET /bins
  def index
    if params[:search] && params[:search].to_i.positive?
      @bin = policy_scope(Bin).find params[:search]
      redirect_to storage_unit_bin_path(id: @bin.id, storage_unit_id: @bin.storage_unit.id) and return
    else
      @bins = policy_scope(Bin).all.order(:id)
    end

    @pagy, @bins = pagy(@bins.sort_by_params(params[:sort], sort_direction), items: 12)
  end

  # GET /bins/1
  def show
  end

  # GET /bins/new
  def new
    @bin = @storage_unit.bins.new

    authorize @bin
  end

  # GET /bins/1/edit
  def edit
  end

  # POST /bins
  def create
    @bin = @storage_unit.bins.new(permitted_attributes(Bin))

    authorize @bin

    respond_to do |format|
      if @bin.save
        format.html { redirect_to storage_unit_bins_path(@bin.storage_unit), notice: "Bin was successfully created." }
        format.json { render :show, status: :created, location: @bin }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bin.errors, status: :unprocessable_entity }
      end
    end
  rescue ActiveRecord::RecordNotUnique
    redirect_to storage_unit_bins_path(@bin.storage_unit), notice: "That bin number has already been used"
  end

  # PATCH/PUT /bins/1
  def update
    @bin.images.attach(params[:bin][:images]) if params[:bin][:images].present?

    respond_to do |format|
      if @bin.update(permitted_attributes(@bin))
        format.html { redirect_to storage_unit_bin_path(id: @bin.id, storage_unit_id: @bin.storage_unit.id), notice: "Bin was successfully updated." }
        format.json { render :show, status: :ok, location: @bin }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bins/1
  def destroy
    @bin.destroy
    respond_to do |format|
      format.html { redirect_to storage_unit_bins_path(@bin.storage_unit), notice: "Bin was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_bin
    @bin = @storage_unit.bins.find(params[:id])

    authorize @bin
  rescue ActiveRecord::RecordNotFound
    redirect_to bins_path, notice: "Not found"
  end

  def set_storage_unit
    @storage_unit = StorageUnit.find(params[:storage_unit_id])
  end
end
