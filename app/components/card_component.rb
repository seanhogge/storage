# frozen_string_literal: true

class CardComponent < ViewComponent::Base
  def initialize(title:, footer:, css_class: nil)
    @title = title
    @footer = footer
    @css_class = css_class
  end

  def call
    html = <<-HTML
    <div class="border rounded shadow-md p-4 bg-white m-4 #{@css_class}">
      <div class="flex justify-between items-center mb-4">
        <h3 class="text-xl font-bold leading-none py-2 whitespace-nowrap">
          #{@title}
        </h3>
      </div>
      <div class="basis-1/4">
        #{content}
      </div>
    </div>
    HTML
    html.html_safe
  end
end
