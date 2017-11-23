# frozen_string_literal: true

require "rails_helper"

RSpec.describe Gretel::Jsonld::ViewHelpers, type: :helper do
  describe "#jsonld_breadcrumbs" do
    subject { helper.jsonld_breadcrumbs(link_current_to_request_path: false) }

    context "when #breadcrumb is not called in advance" do
      it { is_expected.to eq "" }
    end

    context "when #breadcrumb is called in advance" do
      before do
        helper.breadcrumb(:with_root)
      end

      let(:expectation) do
        JSON.generate(
          "@context": "http://schema.org",
          "@type": "BreadcrumbList",
          itemListElement: [{
            "@type": "ListItem",
            position: 1,
            item: {
              "@id": "http://test.host/",
              name: "Home"
            }
          },
          {
            "@type": "ListItem",
            position: 2,
            item: {
              "@id": "http://test.host/about",
              name: "About"
            }
          }]
        )
      end

      it { is_expected.to eq %(<script type="application/ld+json">#{expectation}</script>) }
    end
  end
end
