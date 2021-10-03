# frozen_string_literal: true

require "hexlet_code/tag"

module HexletCode
  module Inputs
    class Input
      def self.input(attrs)
        HexletCode::Tag.build("input", attrs)
      end
    end
  end
end
