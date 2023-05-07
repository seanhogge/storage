# frozen_string_literal: true

class ButtonLinkComponent < ViewComponent::Base
  def initialize(href: nil, method:, **options)
    @href = href
    @method = method
    @classes = options[:classes]
    @data = options[:data]
  end

  def call
    link_to content, @href, method: @method, class: "btn #{@classes}", data: @data
  end
end
