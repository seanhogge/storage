# frozen_string_literal: true

class TableHeadComponent < ViewComponent::Base
  def initialize(classes: nil)
    @classes = classes
  end

  def call
    %Q[
      <th class="border bg-gray-200 px-2 border border-gray-300 dark:bg-gray-600 #{@classes}">
        #{@th || content}
      </th>
    ].html_safe
  end
end
