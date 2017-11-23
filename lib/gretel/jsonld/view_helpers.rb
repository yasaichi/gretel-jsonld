# frozen_string_literal: true

require "action_view"
require "gretel"
require "gretel/jsonld/breadcrumb/list"

module Gretel
  module Jsonld
    module ViewHelpers
      def jsonld_breadcrumbs(options = {})
        ::Gretel::Jsonld::Breadcrumb::List.new(breadcrumbs(options))
      end
    end
  end
end

ActionView::Base.include(Gretel::Jsonld::ViewHelpers)
