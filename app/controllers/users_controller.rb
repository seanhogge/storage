class UsersController < ApplicationController
  before_action :set_user
  after_action :verify_authorized

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    authorize @user

    @user.attributes = user_params

    if @user.save
      redirect_to user_path(@user), notice: "Changes saved"
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :avatar,
      :name,
      :time_zone,
      :password,
      :password_confirmation
    )
  end
end
