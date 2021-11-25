# frozen_string_literal: true

require 'hexlet_code/tag'

module HexletCode
  # Class to render form label
  class Label
    attr_reader :input

    def initialize(attrs)
      @input = {
        type: 'label',
        attrs: attrs
      }
    end

    def render
      type, attrs = input.values_at(:type, :attrs)
      HexletCode::Tag.build(type, attrs) { attrs[:for].capitalize }
    end
  end
end
