# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  class << self
    def form_for(user, options = {})
      fb = HexletCode::FormBuilder.new user
      fields = yield(fb) if block_given?
      "<form action=\"#{options[:url] || "#"}\" method=\"post\">#{fields ? fields.join("") : ""}</form>"
    end
  end

  class FormBuilder
    attr_reader :data
    attr_accessor :fields

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

  class Tag
    @single_tags = %w[img br input]
    @pair_tags = %w[a label div span textarea select]

    DEFAULT_ATTRS_TAG = {
      "input" => {
        type: "text"
      },
      "textarea" => {
        cols: 20,
        rows: 40
      }
    }

    class << self
      def build(name, options = {}, &block)
        return build_single_tag(name, options) if @single_tags.include? name
        return build_pair_tag(name, options, &block) if @pair_tags.include? name
      end

      def build_single_tag(name, attrs)
        default_attrs = get_default_attrs(name)
        full_attrs = default_attrs.merge(attrs)
        "<#{name}#{create_attrs_string(full_attrs)}>"
      end

      def build_pair_tag(name, attrs, &block)
        content = block_given? ? block.call : ""
        default_attrs = get_default_attrs(name)
        full_attrs = default_attrs.merge(attrs)
        "<#{name}#{create_attrs_string(full_attrs)}>#{content}</#{name}>"
      end

      def create_attrs_string(options)
        return "" if options.empty?

        options_array = options.map { |key, value| "#{key}=\"#{value}\"" }
        " #{options_array.join " "}"
      end

      def get_default_attrs(name)
        default_attrs = DEFAULT_ATTRS_TAG[name]
        default_attrs.nil? ? {} : default_attrs
      end
    end
  end

  module Inputs
    class InputBlock
      def self.input(attrs)
        HexletCode::Tag.build("input", attrs)
      end
    end

    class TextBlock
      def self.input(attrs, value)
        HexletCode::Tag.build("textarea", attrs) { value }
      end
    end

    class SelectBlock
      def self.input(attrs, value, collection)
        content = create_select_options(collection, value)
        HexletCode::Tag.build("select", attrs) { content }
      end

      def self.create_select_options(collection, selected)
        collection.map { |i| "<option value=\"#{i}\"#{i == selected ? " selected" : ""}>#{i}</option>" }.join ""
      end
    end
  end
end
