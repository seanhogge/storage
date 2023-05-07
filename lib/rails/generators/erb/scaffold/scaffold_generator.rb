require File.join(Gem::Specification.find_by_name("railties").full_gem_path, "lib/rails/generators/erb/scaffold/scaffold_generator")

module Erb
  module Generators
    class ScaffoldGenerator
      # Enhance the Rails scaffold generator

      def index_partial
        template "index_partial.html.slim", File.join("app/views", controller_file_path, "_index.html.slim")
      end

      def list_partial
        template "_list.html.slim", File.join("app/views", controller_file_path, "_list.html.slim")
      end
    end
  end
end
