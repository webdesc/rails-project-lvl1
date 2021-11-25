# frozen_string_literal: true

module HexletCode
  # Class to build tag
  class Tag
    @single_tags = %w[img br input]
    @pair_tags = %w[a label div span textarea select]

    DEFAULT_ATTRS_TAG = {
      'input' => {
        type: 'text'
      },
      'textarea' => {
        cols: 20,
        rows: 40
      }
    }.freeze

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
        content = block_given? ? block.call : ''
        default_attrs = get_default_attrs(name)
        full_attrs = default_attrs.merge(attrs)
        "<#{name}#{create_attrs_string(full_attrs)}>#{content}</#{name}>"
      end

      def create_attrs_string(options)
        return '' if options.empty?

        options_array = options.map { |key, value| "#{key}=\"#{value}\"" }
        " #{options_array.join ' '}"
      end

      def get_default_attrs(name)
        default_attrs = DEFAULT_ATTRS_TAG[name]
        default_attrs.nil? ? {} : default_attrs
      end
    end
  end
end
