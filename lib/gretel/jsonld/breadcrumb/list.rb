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

        def render
          return "" if empty?

          content = JSON.generate(
            "@context": "http://schema.org",
            "@type": "BreadcrumbList",
            itemListElement: item_list_element,
          )

          context.content_tag(:script, content.html_safe, type: "application/ld+json")
        end
        alias :to_s :render

        # rubocop:disable Metrics/LineLength
        (::Gretel::Renderer::LinkCollection.public_instance_methods - public_instance_methods).each do |name|
          define_method(name) do |*args, &block|
            @link_collection.public_send(name, *args, &block)
          end
        end

        private

        def item_list_element
          map.with_index(1) do |link, index|
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
