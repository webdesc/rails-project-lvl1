# frozen_string_literal: true

require 'hexlet_code/tag'

module HexletCode
  module Inputs
    # Class to render form input
    class Input
      attr_reader :input

      def initialize(attrs)
        @input = {
          type: 'input',
          attrs: attrs
        }
      end

      def render
        type, attrs = input.values_at(:type, :attrs)
        HexletCode::Tag.build(type, attrs)
      end
    end
  end
end
