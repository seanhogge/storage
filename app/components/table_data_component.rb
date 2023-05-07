# frozen_string_literal: true

class TableDataComponent < ViewComponent::Base
  def initialize(classes: nil)
    @classes = classes
  end

  def call
    %Q[
    <td class="px-2 #{@classes}">
      #{content}
    </td>
    ].html_safe
  end
end
