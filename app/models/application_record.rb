class ApplicationRecord < ActiveRecord::Base
  include ActionView::RecordIdentifier

  primary_abstract_class

  # Orders results by column and direction
  def self.sort_by_params(column, direction)
    sortable_column = column.presence_in(sortable_columns) || "created_at"
    order(sortable_column => direction)
  end

  # Returns an array of sortable columns on the model
  # Used with the Sortable controller concern
  #
  # Override this method to add/remove sortable columns
  def self.sortable_columns
    @sortable_columns ||= columns.map(&:name)
  end

  def self.view_columns
    column_names - %w[id created_at updated_at active user_id]
  end

  def self.column_display
    {
      "id" => {name: "ID", class: "text-center"},
      "created_at" => {name: "Created", class: "text-right"},
      "updated_at" => {name: "Updated", class: "text-right"}
    }
  end
end
