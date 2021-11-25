# frozen_string_literal: true

require 'active_support'

module HexletCode
  # Module to build form input fields
  module Inputs
    extend ActiveSupport::Autoload
    autoload :Input
    autoload :Text
    autoload :Select
  end
end
