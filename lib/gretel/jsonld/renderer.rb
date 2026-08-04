# frozen_string_literal: true

require "active_support"
require "active_support/core_ext/string/output_safety"
require "json"
require "gretel/jsonld/breadcrumb/list"
require "gretel/jsonld/breadcrumb/list_item"
require "uri"

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
          to_breadcrumb_list(link_collection)
            .yield_self { |list| ::JSON.generate(list) }
            .yield_self { |json| ::ERB::Util.json_escape(json) }
            .html_safe,
          type: "application/ld+json",
        )
      end

      private

      def resolve_uri(uri_reference)
        ::URI.join(@view_context.request.base_url, uri_reference)
      end

      # :reek:FeatureEnvy
      def to_breadcrumb_list(link_collection)
        link_collection
          .select(&:url)
          .map.with_index(1) { |link, position|
            ::Gretel::JSONLD::Breadcrumb::ListItem.new(
              position: position,
              title: link.text,
              url: resolve_uri(link.url),
            )
          }.yield_self { |items| ::Gretel::JSONLD::Breadcrumb::List.new(items) }
      end
    end
  end
end
