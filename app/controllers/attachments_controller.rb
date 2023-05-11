class AttachmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_attachment_and_record

  def destroy
    @attachment.purge_later if @record.user == current_user
    redirect_back fallback_location: root_path
  end

  private

  def set_attachment_and_record
    @attachment = ActiveStorage::Attachment.find params[:id]
    @record = @attachment.record
  end
end
