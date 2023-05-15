class Mark < ApplicationRecord
  belongs_to :markable, polymorphic: true

  # Broadcast changes in realtime with Hotwire
  # after_create_commit -> { broadcast_prepend_later_to :marks, partial: "marks/index", locals: { mark: self } }
  # after_update_commit -> {
  #   broadcast_replace_later_to self
  #   broadcast_replace_later_to :marks, partial: "marks/index", target: dom_id(self, :index)
  # }
  # after_destroy_commit -> { broadcast_remove_to :marks, target: dom_id(self, :index) }

  enum disposition: { keep: 0, donate: 1, trash: 2 }

  class << self
    def form_select
      Mark.dispositions.map { |disposition| [disposition.first.titleize, disposition.first] }
    end
  end
end
