# frozen_string_literal: true

class ButtonComponent < ViewComponent::Base
  def initialize(classes: nil, **options)
    @classes = classes
    @data = options[:data]
  end

  def call
    button_tag content, class: "btn #{@classes}", data: @data
  end
end
