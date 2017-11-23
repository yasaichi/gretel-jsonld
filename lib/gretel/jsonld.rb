# frozen_string_literal: true

require "gretel/jsonld/version"

if defined?(Rails)
  require "gretel/jsonld/railtie"
else
  require "gretel/jsonld/view_helpers"
end
