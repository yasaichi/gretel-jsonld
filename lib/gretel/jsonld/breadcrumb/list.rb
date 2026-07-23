# frozen_string_literal: true

require "json"

module Gretel
  module JSONLD
    module Breadcrumb
      class List
        def initialize(items)
          @items = items
        end

        def to_json(*args)
          {
            "@context": "http://schema.org",
            "@type": "BreadcrumbList",
            itemListElement: @items
          }.to_json(*args)
        end
      end
    end
  end
end
