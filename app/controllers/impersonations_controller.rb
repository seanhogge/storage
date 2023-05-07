class ImpersonationsController < ApplicationController
  before_action :set_user, only: [ :create ]

  def index
    @users = User.all.order(:last_name)
  end

  def create
    impersonate_user(@user)
    if @user.admin?
      redirect_back fallback_location: root_path
    else
      redirect_to root_path
    end
  end

  def destroy
    stop_impersonating_user
    redirect_back fallback_location: root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
