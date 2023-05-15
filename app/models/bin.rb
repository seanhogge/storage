class Bin < ApplicationRecord
  belongs_to :storage_unit

  has_one :mark, as: :markable
  has_one :user, through: :storage_unit
  has_many :contents, dependent: :destroy
  has_many_attached :images, dependent: :destroy

  # Broadcast changes in realtime with Hotwire
  # after_create_commit -> { broadcast_prepend_later_to :bins, partial: "bins/index", locals: { bin: self } }
  # after_update_commit -> {
  #   broadcast_replace_later_to self
  #   broadcast_replace_later_to :bins, partial: "bins/index", target: dom_id(self, :index)
  # }
  # after_destroy_commit -> { broadcast_remove_to :bins, target: dom_id(self, :index) }
end
