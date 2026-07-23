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
                "@id": "http://test.host/about",
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
                    "@id": "http://test.host/about",
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

      describe "link_current_to_request_path option" do
        let(:options) { { link_current_to_request_path: link_current_to_request_path } }
        let(:breadcrumb_key) { :with_root }

        before do
          allow(helper.request).to receive(:fullpath).and_return("/requested")
        end

        context "when set to false" do
          let(:link_current_to_request_path) { false }
          it { is_expected.to eq(full_list) }
        end

        context "when set to true" do
          let(:link_current_to_request_path) { true }

          # TODO: Convert this relative request path to an absolute URL. Google reports
          # it as a non-critical `Invalid URL in field "id"` issue.
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
                },
                {
                  "@type": "ListItem",
                  position: 2,
                  item: {
                    "@id": "/requested",
                    name: "About"
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
    end
  end
end
