# gretel-jsonld
[![Gem Version](https://badge.fury.io/rb/gretel-jsonld.svg)](http://badge.fury.io/rb/gretel-jsonld)
[![Build Status](https://travis-ci.org/yasaichi/gretel-jsonld.svg?branch=master)](https://travis-ci.org/yasaichi/gretel-jsonld)
[![Code Climate](https://api.codeclimate.com/v1/badges/fc3fd5037eb200bedbf5/maintainability)](https://codeclimate.com/github/yasaichi/gretel-jsonld/maintainability)
[![Test Coverage](https://codeclimate.com/github/yasaichi/gretel-jsonld/badges/coverage.svg)](https://codeclimate.com/github/yasaichi/gretel-jsonld/coverage)

gretel-jsonld enables gretel gem to handle JSON-LD based breadcrumbs.

## Installation
Add this line to your application's `Gemfile`:

```ruby
gem 'gretel-jsonld'
```

And then execute:
```bash
$ bundle
```

## Usage
First, run the installation generator with:

```sh
$ rails generate gretel:install
```

Next, define "crumbs" in `config/breadcrumbs.rb`:

```ruby
# See also: https://github.com/lassebunk/gretel#more-examples

# Root crumb
crumb :root do
  link 'Home', root_path
end

# Issue list
crumb :issues do
  link 'All issues', issues_path
end

# Issue
crumb :issue do |issue|
  link issue.title, issue
  parent :issues
end
```

Then, add this line to your application's layout:

```erb
<%= jsonld_breadcrumbs %>
```

Finally, specify a current breadcrumb in each view:

```erb
<% breadcrumb :issue, @issue %>
```

This will generate the following breadcrumbs, marked up with JSON-LD (indented for readability):

```html
<script type="application/ld+json">
{
  "@context":"http://schema.org",
  "@type":"BreadcrumbList",
  "itemListElement":[
    {
      "@type":"ListItem",
      "position":1,
      "item":{
        "@id":"/",
        "name":"Home"
      }
    },
    {
      "@type":"ListItem",
      "position":2,
      "item":{
        "@id":"/issues",
        "name":"All issues"
      }
    },
    {
      "@type":"ListItem",
      "position":3,
      "item":{
        "@id":"/issues/46",
        "name":"My Issue"
      }
    }
  ]
}
</script>
```

## Options

You can pass `jsonld_breadcrumbs` the same options as `breadcrumbs`:

```erb
<%= jsonld_breadcrumbs link_current_to_request_path: false %>
```

For further information, please see [gretel's documentation](https://github.com/lassebunk/gretel/blob/master/README.md#options).

## Supported versions
Note that gretel-jsonld doesn't support all versions of gretel, Ruby and Rails:

* gretel: gretel-jsonld supports __only 3.x__ for now
* Ruby: gretel 3.x supports __1.9.3 or later__, but gretel-jsonld does __only 2.2.2 or later__
* Rails: gretel 3.x supports __3.1 or later__, but gretel-jsonld does __only 3.2 or later__

## Contributing
You should follow the steps below:

1. [Fork the repository](https://help.github.com/articles/fork-a-repo/)
2. Create a feature branch: `git checkout -b add-new-feature`
3. Commit your changes: `git commit -am 'Add new feature'`
4. Push the branch: `git push origin add-new-feature`
4. [Send us a pull request](https://help.github.com/articles/about-pull-requests/)

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
