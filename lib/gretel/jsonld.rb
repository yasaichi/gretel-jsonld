# frozen_string_literal: true

require "action_view"
require "gretel/jsonld/version"

if defined?(Rails)
  require "gretel/jsonld/railtie"
else
  require "gretel/jsonld/view_helpers"
  ActionView::Base.include(Gretel::JSONLD::ViewHelpers)
end
