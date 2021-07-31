# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end

  class Tag
    @single_tags = %w[img br input]
    @pair_tags = %w[a label div span]

    def self.build(name, options = {}, &block)
      return build_single_tag(name, options) if @single_tags.include? name
      return build_pair_tag(name, options, &block) if @pair_tags.include? name
    end

    private

    def self.build_single_tag(name, options)
      "<#{name}#{create_options(options)}>"
    end

    def self.build_pair_tag(name, options, &block)
      "<#{name}#{create_options(options)}>#{block.call}</#{name}>"
    end

    def self.create_options(options)
      return "" if options.empty?

      options_array = options.map { |key, value| "#{key}=\"#{value}\"" }
      " #{options_array.join " "}"
    end
  end
end
