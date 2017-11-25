# frozen_string_literal: true

require "json"
require "active_support"
require "active_support/json/encoding"

module Gretel
  module JSONLD
    module Breadcrumb
      class ListItem
        def initialize(id:, name:, position:)
          @id = id
          @name = name
          @position = position
        end

        # NOTE: Override #as_json to cope with Rails 4.0 or former
        def as_json(options = nil)
          {
            "@type": "ListItem",
            position: @position,
            item: {
              "@id": @id,
              name: @name,
            }
          }.as_json(options)
        end

        def to_json(*args)
          as_json.to_json(*args)
        end
      end
    end
  end
end
