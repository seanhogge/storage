module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: [:edit, :update]
    after_action :verify_authorized

    def index
      authorize [:admin, :user]

      if params[:search]
        @users = User.where("first_name ILIKE ? OR last_name ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%").order(:id)
      else
        @users = User.all.order(:id)
      end

      @pagy, @users = pagy(@users.sort_by_params(params[:sort], sort_direction), items: 10)
    end

    def edit
      authorize [:admin, @user]
    end

    def update
      authorize [:admin, @user]

      @user.attributes = user_params
      if @user.save
        respond_to do |format|
          format.html { redirect_to admin_users_path }
        end
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :name,
        :email,
        :time_zone,
        :admin
      )
    end
  end
end
