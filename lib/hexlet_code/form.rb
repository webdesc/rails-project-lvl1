# frozen_string_literal: true

module HexletCode
  class Form
    attr_reader :entity
    attr_accessor :config

    def initialize(entity, form_params = {})
      @entity = entity
      @config = {
        method: "post",
        params: form_params,
        fields: []
      }
    end

    def input(attr_name, options = {})
      type = options.fetch(:as, :input)
      collection = options.fetch(:collection, [])
      value = entity[attr_name] || nil
      attrs = { name: attr_name }
      config[:fields] << create_field(:label, { for: attr_name })
      config[:fields] << create_field(type, attrs, value, collection)
    end

    def submit(label = "Save")
      attrs = { type: "submit", value: label, name: "commit" }
      config[:fields] << create_field(:input, attrs)
    end

    def create_field(type, attrs, value = nil, collection = [])
      {
        type: type,
        attrs: attrs,
        value: value,
        collection: collection
      }
    end
  end
end
