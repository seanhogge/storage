# frozen_string_literal: true

class UserSelectComponent < ViewComponent::Base
  def initialize(form:, users:, selected: nil, input_opts: {}, html_opts: {})
    @form = form
    @users = users
    @selected = selected.class == User ? selected.id : selected
    @input_opts = input_opts
    @html_opts = html_opts
  end

  def call
    html = ""
    html += @form.select(:user_id,
        options_for_select(@users.map{|user| [ user.name, user.id ]}, @selected),
        @input_opts,
        @html_opts.merge(
          class: "form-control-ts",
          placeholder: @html_opts[:multiple] ? "User(s)" : "User",
          data: { controller: "select" }
        ))
    html.html_safe
  end
end
