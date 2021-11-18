# frozen_string_literal: true

require "hexlet_code/inputs"
require "hexlet_code/label"

module HexletCode
  class Form
    attr_accessor :entity, :config

    include HexletCode::Inputs

    def initialize(entity, form_params = {})
      @entity = entity
      @config = {
        method: "post",
        params: form_params,
        fields: []
      }
    end

    def input(attr_name, options = {})
      tag_attrs = options.except(:as, :collection)
      type = options.fetch(:as, :input)
      collection = options.fetch(:collection, [])
      value = entity.public_send(attr_name)
      attrs = tag_attrs.merge({ name: attr_name })
      config[:fields] << create_field(:label, { for: attr_name })
      config[:fields] << create_field(type, attrs, value, collection)
    end

    def submit(label = "Save")
      attrs = { type: "submit", value: label, name: "commit" }
      config[:fields] << create_field(:input, attrs)
    end

    def create_field(type, attrs, value = nil, collection = [])
      case type
      when :input
        HexletCode::Inputs::Input.new(attrs.merge((value.nil? ? {} : { value: value })))
      when :text
        HexletCode::Inputs::Text.new(attrs, value)
      when :select
        HexletCode::Inputs::Select.new(attrs, value, collection)
      when :label
        HexletCode::Label.new(attrs)
      end
    end
  end
end
