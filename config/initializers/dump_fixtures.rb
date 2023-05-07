class ActiveRecord::Base
  def dump_fixture(ignore_columns: ["created_at", "updated_at"], append: false, name_column: "id")
    mode = append ? "a+" : "w"
    fixture_file = "#{Rails.root}/test/fixtures/#{self.class.table_name}.yml"

    File.open(fixture_file, mode) do |f|
      if name_column == "id"
        f.puts({"#{self.class.table_name.singularize}_#{id}" => attributes.except(*ignore_columns)}.to_yaml.sub!(/---\s?/, "\n"))
      else
        f.puts({"#{self.send(name_column).parameterize.underscore}" => attributes.except(*ignore_columns)}.to_yaml.sub!(/---\s?/, "\n"))
      end
    end
  end
end

class ActiveRecord::Relation
  def dump_fixture(ignore_columns: ["created_at", "updated_at"], append: false, name_column: "id")
    mode = append ? "a+" : "w"
    fixture_file= "#{Rails.root}/test/fixtures/#{first.class.table_name}.yml"

    File.open(fixture_file, mode) do |file|
      each do |record|
        if name_column == "id"
          file.puts({"#{record.class.table_name.singularize}_#{record.id}" => record.attributes.except(*ignore_columns)}.to_yaml.sub!(/---\s?/, "\n"))
        else
          file.puts({"#{record.send(name_column).parameterize.underscore}" => record.attributes.except(*ignore_columns)}.to_yaml.sub!(/---\s?/, "\n"))
        end
      end
    end
  end
end
