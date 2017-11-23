# frozen_string_literal: true

require "action_view"
require "gretel"
require "gretel/jsonld/renderer"

module Gretel
  module Jsonld
    module ViewHelpers
      def jsonld_breadcrumbs(options = {})
        gretel_jsonld_renderer.render(breadcrumbs(options))
      end

      private

      def gretel_jsonld_renderer
        @_gretel_jsonld_renderer ||= ::Gretel::Jsonld::Renderer.new(self)
      end
    end
  end
end

ActionView::Base.include(Gretel::Jsonld::ViewHelpers)
