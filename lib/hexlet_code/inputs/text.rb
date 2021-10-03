# frozen_string_literal: true

require "hexlet_code/tag"

module HexletCode
  module Inputs
    class Text
      def self.input(attrs, value)
        HexletCode::Tag.build("textarea", attrs) { value }
      end
    end
  end
end
