# frozen_string_literal: true

require "json"
require "active_support"
require "active_support/core_ext/string/output_safety"
require "gretel/jsonld/breadcrumb/list"

module Gretel
  module JSONLD
    class Renderer
      def initialize(view_context)
        @view_context = view_context
      end

      def render(link_collection)
        return "" if link_collection.empty?

        @view_context.content_tag(
          :script,
          ::Gretel::JSONLD::Breadcrumb::List.new(link_collection)
            .yield_self { |list| JSON.generate(list) }
            .yield_self { |json| ::ERB::Util.json_escape(json) }
            .html_safe,
          type: "application/ld+json",
        )
      end
    end
  end
end
