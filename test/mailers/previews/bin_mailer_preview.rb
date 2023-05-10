# Preview all emails at http://localhost:3000/rails/mailers/bin_mailer
class BinMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/bin_mailer/new_bin
  def new_bin
    BinMailer.new_bin
  end

end
