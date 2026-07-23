# frozen_string_literal: true

require "json"

module Gretel
  module JSONLD
    module Breadcrumb
      class ListItem
        def initialize(position:, title:, url:)
          @position = position
          @title = title
          @url = url
        end

        def to_json(*args)
          {
            "@type": "ListItem",
            position: @position,
            item: {
              "@id": @url,
              name: @title
            }
          }.to_json(*args)
        end
      end
    end
  end
end
