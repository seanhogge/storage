class Content < ApplicationRecord
  belongs_to :bin, touch: true

  enum condition: { poor: 0, questionable: 1, good: 2 }

  # Broadcast changes in realtime with Hotwire
  # after_create_commit -> { broadcast_prepend_later_to :contents, partial: "contents/index", locals: { content: self } }
  # after_update_commit -> {
  #   broadcast_replace_later_to self
  #   broadcast_replace_later_to :contents, partial: "contents/index", target: dom_id(self, :index)
  # }
  # after_destroy_commit -> { broadcast_remove_to :contents, target: dom_id(self, :index) }

  def condition_classes
    case condition
    when "poor"
      %w[text-red-600]
    when "questionable"
      %w[text-gold-600]
    when "good"
      %w[text-green-600]
    end
  end
end
