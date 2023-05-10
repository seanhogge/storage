class BinMailer < ApplicationMailer
  before_action { @user = params[:user] }

  def new_bin
    @greeting = "Hi"

    mail from: "sean@seanhogge.com", to: @user.email, message_stream: "outbound"
  end
end
