# frozen_string_literal: true

require_relative "hexlet_code/version"
require "hexlet_code/form_builder"

module HexletCode
  class Error < StandardError; end

  class << self
    def form_for(user, options = {})
      fb = HexletCode::FormBuilder.new user
      fields = yield(fb) if block_given?
      "<form action=\"#{options[:url] || "#"}\" method=\"post\">#{fields ? fields.join("") : ""}</form>"
    end
  end
end
