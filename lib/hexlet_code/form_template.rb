# frozen_string_literal: true

require 'hexlet_code/tag'

module HexletCode
  # Class to render form template
  class FormTemplate
    def self.render(form)
      method, params, fields = form.values_at(:method, :params, :fields)
      tags = fields.map(&:render)
      "<form action=\"#{params[:url] || '#'}\" method=\"#{method}\">#{tags.join('')}</form>"
    end
  end
end
