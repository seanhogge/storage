class StorageUnit < ApplicationRecord
  belongs_to :user

  has_many :access_codes
  has_many :bins
  has_many :contents, through: :bins

  # Broadcast changes in realtime with Hotwire
  # after_create_commit -> { broadcast_prepend_later_to :storage_units, partial: "storage_units/index", locals: { storage_unit: self } }
  # after_update_commit -> {
  #   broadcast_replace_later_to self
  #   broadcast_replace_later_to :storage_units, partial: "storage_units/index", target: dom_id(self, :index)
  # }
  # after_destroy_commit -> { broadcast_remove_to :storage_units, target: dom_id(self, :index) }
end
