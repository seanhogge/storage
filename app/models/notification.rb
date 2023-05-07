class Notification < ApplicationRecord
  include Noticed::Model
  belongs_to :recipient, polymorphic: true

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> {
    broadcast_replace_later_to :notifications_menu, partial: "notifications/menu", target: :notifications_menu
    broadcast_prepend_later_to :notifications, partial: "notifications/index", target: :notifications
  }
  after_update_commit -> {
    broadcast_replace_later_to self
    broadcast_replace_later_to :notifications_menu, partial: "notifications/menu", target: :notifications_menu
    broadcast_replace_later_to :notifications, partial: "notifications/index", target: dom_id(self, :index)
  }
  after_destroy_commit -> {
    broadcast_remove_to :notifications_menu, target: :notifications_menu
    broadcast_remove_to :notifications, target: dom_id(self, :index)
  }

  def status
    return "read" if read?
    return "unread" if unread?
  end
end
