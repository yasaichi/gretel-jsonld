# gretel-jsonld

[![Gem Version](https://badge.fury.io/rb/gretel-jsonld.svg)](http://badge.fury.io/rb/gretel-jsonld)
[![CI](https://github.com/yasaichi/gretel-jsonld/actions/workflows/ci.yml/badge.svg)](https://github.com/yasaichi/gretel-jsonld/actions/workflows/ci.yml)
[![Code Coverage](https://qlty.sh/gh/yasaichi/projects/gretel-jsonld/coverage.svg)](https://qlty.sh/gh/yasaichi/projects/gretel-jsonld)

gretel-jsonld enables [gretel](https://github.com/kzkn/gretel) to generate
breadcrumbs using JSON-LD structured data.

## Installation

In your `Gemfile`:

```ruby
gem "gretel-jsonld"
```

And run:

```bash
$ bundle install
```

## Example

Start by generating the breadcrumbs configuration file:

```sh
$ rails generate gretel:install
```

Then, in `config/breadcrumbs.rb`:

```ruby
# Root crumb
crumb :root do
  link "Home", root_path
end

# Issue list
crumb :issues do
  link "All issues", issues_path
end

# Issue
crumb :issue do |issue|
  link issue.title, issue
  parent :issues
end
```

At the top of `app/views/issues/show.html.erb`, set the current breadcrumb
(assuming you have loaded `@issue` with an issue):

```erb
<% breadcrumb :issue, @issue %>
```

Then, in `app/views/layouts/application.html.erb`:

```erb
<%= jsonld_breadcrumbs %>
```

For a request to `https://example.com/issues/46`, this will generate the
following JSON-LD (indented for readability):

```html
<script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    "itemListElement": [
      {
        "@type": "ListItem",
        "position": 1,
        "item": {
          "@id": "https://example.com/",
          "name": "Home"
        }
      },
      {
        "@type": "ListItem",
        "position": 2,
        "item": {
          "@id": "https://example.com/issues",
          "name": "All issues"
        }
      },
      {
        "@type": "ListItem",
        "position": 3,
        "item": {
          "@id": "https://example.com/issues/46",
          "name": "My Issue"
        }
      }
    ]
  }
</script>
```

## Options

You can pass options to `<%= jsonld_breadcrumbs %>`, e.g.:

```erb
<%= jsonld_breadcrumbs autoroot: false, link_current_to_request_path: false %>
```

Options that change the breadcrumb collection also affect the JSON-LD output:

Option                   | Description                                                                                                                 | Default
------------------------ | --------------------------------------------------------------------------------------------------------------------------- | -------
:autoroot                | Whether it should automatically add the `:root` crumb to the `BreadcrumbList` if no parent is given.                       | True
:display_single_fragment | Whether it should output the `BreadcrumbList` if it includes only one item.                                                  | False
:link_current_to_request_path | Whether the current crumb's `item.@id` in the `BreadcrumbList` should always use the current request path.                    | True

Options concerned only with HTML presentation do not change the JSON-LD
output. For example, `link_current` controls whether the current crumb is
rendered as an HTML link, but the current crumb always includes `item.@id` in
JSON-LD.

For further information, please see
[Gretel's documentation](https://github.com/kzkn/gretel#options).

## Nice to know

### Breadcrumb URLs

Relative breadcrumb paths are resolved against the current request's base URL.
Absolute breadcrumb URLs are used as-is.

Breadcrumbs without link URLs are omitted from the JSON-LD output because each
breadcrumb item is identified by `@id`, whose value must be an IRI reference
under the
[JSON-LD specification](https://www.w3.org/TR/json-ld11/#node-objects).

## Supported versions

gretel-jsonld supports gretel 3.0 or later without an upper version bound.
The supported version ranges are:

| gretel | Rails | Ruby |
| --- | --- | --- |
| 3.x | 5.x | 2.5 or later |
| 4.x | 5.1 through 7.1 | 2.5 or later |
| 5.x | 6.1 or later | 3.0 or later |

CI covers the lowest and highest supported Rails majors for each gretel major.

## Contributing

To contribute:

1. [Fork the repository](https://help.github.com/articles/fork-a-repo/)
2. Create a feature branch: `git checkout -b add-new-feature`
3. Commit your changes: `git commit -am 'Add new feature'`
4. Push the branch: `git push origin add-new-feature`
5. [Send us a pull request](https://help.github.com/articles/about-pull-requests/)

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
