# frozen_string_literal: true

require "json"
require "gretel/jsonld/breadcrumb/list_item"

module Gretel
  module Jsonld
    module Breadcrumb
      class List
        def initialize(link_collection)
          @link_collection = link_collection
        end

        def to_json(*args)
          {
            "@context": "http://schema.org",
            "@type": "BreadcrumbList",
            itemListElement: item_list_element,
          }.to_json(*args)
        end

        private

        def item_list_element
          @link_collection.map.with_index(1) do |link, index|
            ::Gretel::Jsonld::Breadcrumb::ListItem.new(
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
