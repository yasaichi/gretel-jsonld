# frozen_string_literal: true

require "active_support/lazy_load_hooks"
require "gretel/jsonld/view_helpers"

module Gretel
  module JSONLD
    class Railtie < ::Rails::Railtie
      initializer "gretel.jsonld", after: "gretel.view_helpers" do
        ::ActiveSupport.on_load(:action_view) do
          include ::Gretel::JSONLD::ViewHelpers
        end
      end
    end
  end
end
