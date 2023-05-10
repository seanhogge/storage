class BinMailer < ApplicationMailer
  before_action { @user = params[:user] }

  def new_bin
    @greeting = "Hi"

    mail to: @user.email
  end
end
