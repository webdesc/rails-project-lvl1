# frozen_string_literal: true

require "hexlet_code/tag"

module HexletCode
  module Inputs
    class InputBlock
      def self.input(attrs)
        HexletCode::Tag.build("input", attrs)
      end
    end

    class TextBlock
      def self.input(attrs, value)
        HexletCode::Tag.build("textarea", attrs) { value }
      end
    end

    class SelectBlock
      def self.input(attrs, value, collection)
        content = create_select_options(collection, value)
        HexletCode::Tag.build("select", attrs) { content }
      end

      def self.create_select_options(collection, selected)
        collection.map { |i| "<option value=\"#{i}\"#{i == selected ? " selected" : ""}>#{i}</option>" }.join ""
      end
    end
  end
end
