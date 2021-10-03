# frozen_string_literal: true

require "hexlet_code/inputs"

module HexletCode
  class FormBuilder
    attr_reader :config

    include HexletCode::Inputs

    def initialize() end

    def create(config)
      method, params, fields = config.values_at(:method, :params, :fields)
      tags = fields.map do |field|
        type, attrs, value, collection = field.values_at(:type, :attrs, :value, :collection)
        factory_input(type, attrs, value, collection)
      end
      "<form action=\"#{params[:url] || "#"}\" method=\"#{method}\">#{tags.join("")}</form>"
    end

    private

    def factory_input(type, attrs, value, collection)
      case type
      when :input
        HexletCode::Inputs::Input.input(attrs.merge((value.nil? ? {} : { value: value })))
      when :text
        HexletCode::Inputs::Text.input(attrs, value)
      when :select
        HexletCode::Inputs::Select.input(attrs, value, collection)
      when :label
        HexletCode::Tag.build("label", attrs) { attrs[:for].capitalize }
      end
    end
  end
end
