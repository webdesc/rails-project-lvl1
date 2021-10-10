# frozen_string_literal: true

require_relative "hexlet_code/version"
require "hexlet_code/form"
require "hexlet_code/form_template"

module HexletCode
  class Error < StandardError; end

  def self.form_for(user, options = {}, &block)
    form = HexletCode::Form.new(user, options, &block)
    yield(form) if block_given?
    HexletCode::FormTemplate.render(form.config)
  end
end
