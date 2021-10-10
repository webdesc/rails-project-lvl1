# frozen_string_literal: true

require "hexlet_code/tag"

module HexletCode
  module Inputs
    class Select
      attr_reader :input

      def initialize(attrs, value, collection)
        @input = {
          type: "select",
          attrs: attrs,
          value: value,
          collection: collection
        }
      end

      def render
        type, attrs, value, collection = input.values_at(:type, :attrs, :value, :collection)
        content = create_select_options(collection, value)
        HexletCode::Tag.build(type, attrs) { content }
      end

      private

      def create_select_options(collection, selected)
        collection.map { |i| "<option value=\"#{i}\"#{i == selected ? " selected" : ""}>#{i}</option>" }.join ""
      end
    end
  end
end
