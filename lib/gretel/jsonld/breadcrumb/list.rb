# frozen_string_literal: true

require "json"
require "active_support"
require "active_support/json/encoding"
require "gretel/jsonld/breadcrumb/list_item"

module Gretel
  module JSONLD
    module Breadcrumb
      class List
        def initialize(link_collection)
          @link_collection = link_collection
        end

        # NOTE: Override #as_json to cope with Rails 4.0 or former
        def as_json(options = nil)
          {
            "@context": "http://schema.org",
            "@type": "BreadcrumbList",
            itemListElement: item_list_element,
          }.as_json(options)
        end

        def to_json(*args)
          as_json.to_json(*args)
        end

        private

        def item_list_element
          @link_collection.map.with_index(1) do |link, index|
            ::Gretel::JSONLD::Breadcrumb::ListItem.new(
              id: link.url,
              name: link.text,
              position: index,
            )
          end
        end
      end
    end
  end
end
