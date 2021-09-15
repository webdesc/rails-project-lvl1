# frozen_string_literal: true

require "hexlet_code/inputs"

module HexletCode
  class FormBuilder
    attr_reader :data
    attr_accessor :fields

    include HexletCode::Inputs

    def initialize(data)
      @data = data
      @fields = []
    end

    def input(attr_name, options = {})
      type = options.fetch(:as, :input)
      collection = options.fetch(:collection, [])
      value = data[attr_name] || ""
      attrs = { name: attr_name }
      fields << factory_input_block(type, attrs, value, collection)
    end

    def factory_input_block(type, attrs, value, collection)
      case type
      when :input
        HexletCode::Inputs::InputBlock.input(attrs.merge({ value: value }))
      when :text
        HexletCode::Inputs::TextBlock.input(attrs, value)
      when :select
        HexletCode::Inputs::SelectBlock.input(attrs, value, collection)
      else
        "Not implemented"
      end
    end
  end
end
