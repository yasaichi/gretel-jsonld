# frozen_string_literal: true

require "active_support/lazy_load_hooks"
require "rails/railtie"

module Gretel
  module Jsonld
    class Railtie < ::Rails::Railtie
      initializer "gretel.jsonld" do
        ::ActiveSupport.on_load(:action_view) do
          require "gretel/jsonld/view_helpers"
        end
      end
    end
  end
end
