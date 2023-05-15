class ContentsController < ApplicationController
  before_action :set_bin_and_storage_unit
  before_action :set_content, only: [:show, :edit, :update, :destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  # GET /contents
  def index
    if params[:search]
      @contents = policy_scope(Content).where("name ILIKE ?", "%#{params[:search]}%").order(:id)
    else
      @contents = policy_scope(Content).all.order(:id)
    end

    @pagy, @contents = pagy(@contents.sort_by_params(params[:sort], sort_direction), items: 50)
  end

  # GET /contents/1
  def show
  end

  # GET /contents/new
  def new
    @content = Content.new

    authorize @content
  end

  # GET /contents/1/edit
  def edit
  end

  # POST /contents
  def create
    @content = @bin.contents.new(permitted_attributes(Content))

    authorize @content

    respond_to do |format|
      if @content.save
        format.html { redirect_to storage_unit_bin_path(id: @content.bin.id, storage_unit_id: @content.bin.storage_unit.id), notice: "Content was successfully created." }
        format.json { render :show, status: :created, location: @content }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contents/1
  def update
    if params[:content][:mark]
      @content.mark.destroy
      @content.mark = Mark.new(disposition: params[:content][:mark])
    end

    respond_to do |format|
      if @content.update(permitted_attributes(@content))
        format.html { redirect_to storage_unit_bin_path(@content.bin), notice: "Content was successfully updated." }
        format.json { render :show, status: :ok, location: @content }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contents/1
  def destroy
    @content.destroy
    respond_to do |format|
      format.html { redirect_to storage_unit_bin_path(id: @content.bin.id, storage_unit_id: @content.bin.storage_unit.id), notice: "Content was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_bin_and_storage_unit
    @storage_unit = StorageUnit.find(params[:storage_unit_id])
    @bin = @storage_unit.bins.find(params[:bin_id])
  end

  def set_content
    @content = Content.find(params[:id])

    authorize @content
  rescue ActiveRecord::RecordNotFound
    redirect_to contents_path, notice: "Not found"
  end
end
