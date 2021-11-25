# frozen_string_literal: true

require_relative 'hexlet_code/version'
require 'hexlet_code/form'
require 'hexlet_code/form_template'

# Module to generage form
module HexletCode
  def self.form_for(entity, options = {})
    form = HexletCode::Form.new(entity, options)
    yield(form) if block_given?
    HexletCode::FormTemplate.render(form.config)
  end
end
