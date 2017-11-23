# frozen_string_literal: true

require "json"

module Gretel
  module Jsonld
    module Breadcrumb
      class ListItem
        def initialize(id:, name:, position:)
          @id = id
          @name = name
          @position = position
        end

        def to_json(*args)
          {
            "@type": "ListItem",
            position: @position,
            item: {
              "@id": @id,
              name: @name,
            }
          }.to_json(*args)
        end
      end
    end
  end
end
