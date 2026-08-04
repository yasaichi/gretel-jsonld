# frozen_string_literal: true

require "rails_helper"

RSpec.describe Gretel::JSONLD::ViewHelpers, type: :helper do
  describe "#jsonld_breadcrumbs" do
    subject do
      raw_subject
        .yield_self { |s| Nokogiri::HTML.fragment(s).at_css('script[type="application/ld+json"]') }
        .yield_self { |e| JSON.parse(e.text, symbolize_names: true) }
    end

    let(:raw_subject) { helper.jsonld_breadcrumbs(link_current_to_request_path: false, **options) }

    context "when #breadcrumb is not called in advance" do
      let(:options) { {} }
      it { expect(raw_subject).to eq("") }
    end

    context "when #breadcrumb is called in advance" do
      let(:full_list) do
        {
          "@context": "http://schema.org",
          "@type": "BreadcrumbList",
          itemListElement: [
            {
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
                "@id": "http://test.host/about?foo=bar",
                name: "About"
              }
            }
          ]
        }
      end

      before do
        helper.breadcrumb(breadcrumb_key)
      end

      describe "autoroot option" do
        let(:options) { { autoroot: autoroot, display_single_fragment: true } }
        let(:breadcrumb_key) { :with_root }

        context "when set to true" do
          let(:autoroot) { true }
          it { is_expected.to eq(full_list) }
        end

        context "when set to false" do
          let(:autoroot) { false }
          let(:expectation) do
            {
              "@context": "http://schema.org",
              "@type": "BreadcrumbList",
              itemListElement: [
                {
                  "@type": "ListItem",
                  position: 1,
                  item: {
                    "@id": "http://test.host/about?foo=bar",
                    name: "About"
                  }
                }
              ]
            }
          end

          it { is_expected.to eq(expectation) }
        end
      end

      describe "display_single_fragment option" do
        let(:options) { { display_single_fragment: display_single_fragment } }
        let(:breadcrumb_key) { :root }

        context "when set to false" do
          let(:display_single_fragment) { false }
          it { expect(raw_subject).to eq("") }
        end

        context "when set to true" do
          let(:display_single_fragment) { true }
          let(:expectation) do
            {
              "@context": "http://schema.org",
              "@type": "BreadcrumbList",
              itemListElement: [
                {
                  "@type": "ListItem",
                  position: 1,
                  item: {
                    "@id": "http://test.host/",
                    name: "Home"
                  }
                }
              ]
            }
          end

          it { is_expected.to eq(expectation) }
        end
      end

      describe "the other options" do
        let(:options) { { link_current: true, semantic: true, style: :bootstrap } }
        let(:breadcrumb_key) { :with_root }

        it { is_expected.to eq(full_list) }
      end

      describe "XSS prevention" do
        let(:options) { { autoroot: false, display_single_fragment: true } }
        let(:breadcrumb_key) { :with_xss_payload }

        let(:expectation) do
          {
            "@context": "http://schema.org",
            "@type": "BreadcrumbList",
            itemListElement: [
              {
                "@type": "ListItem",
                position: 1,
                item: {
                  "@id": "/xss",
                  name: "</script><script>alert(1)</script>"
                }
              }
            ]
          }
        end

        it { is_expected.to eq(expectation) }
      end
    end
  end
end
