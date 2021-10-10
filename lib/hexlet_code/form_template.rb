# frozen_string_literal: true

require "hexlet_code/tag"

module HexletCode
  class FormTemplate
    def self.render(form)
      method, params, fields = form.values_at(:method, :params, :fields)
      tags = fields.map(&:render)
      "<form action=\"#{params[:url] || "#"}\" method=\"#{method}\">\n#{tags.join("")}\n</form>"
    end
  end
end
