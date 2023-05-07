class AccessCode < ApplicationRecord
  belongs_to :storage_unit

  # Broadcast changes in realtime with Hotwire
  after_create_commit -> { broadcast_prepend_later_to :access_codes, partial: "access_codes/index", locals: { access_code: self } }
  after_update_commit -> {
    broadcast_replace_later_to self
    broadcast_replace_later_to :access_codes, partial: "access_codes/index", target: dom_id(self, :index)
  }
  after_destroy_commit -> { broadcast_remove_to :access_codes, target: dom_id(self, :index) }
end
