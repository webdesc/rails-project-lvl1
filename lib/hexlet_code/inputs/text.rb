# frozen_string_literal: true

require 'hexlet_code/tag'

module HexletCode
  module Inputs
    # Class to render form textarea
    class Text
      attr_reader :input

      def initialize(attrs, value)
        @input = {
          type: 'textarea',
          attrs: attrs,
          value: value
        }
      end

      def render
        type, attrs, value = input.values_at(:type, :attrs, :value)
        HexletCode::Tag.build(type, attrs) { value }
      end
    end
  end
end
