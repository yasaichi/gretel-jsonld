# frozen_string_literal: true

require "json"
require "gretel/jsonld/breadcrumb/list"

module Gretel
  module Jsonld
    class Renderer
      def initialize(view_context)
        @view_context = view_context
      end

      def render(link_collection)
        return "" if link_collection.empty?

        @view_context.content_tag(
          :script,
          JSON.generate(::Gretel::Jsonld::Breadcrumb::List.new(link_collection)).html_safe,
          type: "application/ld+json",
        )
      end
    end
  end
end
