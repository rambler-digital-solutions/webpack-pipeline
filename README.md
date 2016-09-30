# Webpack Pipeline

[![Gem Version](https://badge.fury.io/rb/webpack-pipeline.svg)](https://badge.fury.io/rb/webpack-pipeline) [![Build Status](https://api.travis-ci.org/rambler-digital-solutions/webpack-pipeline.svg?branch=master)](https://travis-ci.org/rambler-digital-solutions/webpack-pipeline)

Webpack-pipeline allows to use default Rails helpers (`image_tag`, `javascript_include_tag`, `stylesheet_link_tag`, etc) to access webpack-generated assets.

Webpack should generate `manifest.json` file with paths to compiled assets in [specified format](#manifest-file-format).

By default webpack-pipeline looking for `config/manifest.json`, but it path may be specified through [configuration](#configuration).

## Installation

Add gem to your Gemfile

```ruby
gem 'webpack-pipeline'
```

## Configuration

```ruby
# config/initializers/webpack_pipeline.rb
Webpack::Manifest.configure do |webpack|
  # Default path: config/manifest.json
  wepback.path = Rails.root.join('path', 'to', 'manifest.json')
end
```

To handle manifest.json while running tests, configure webpack-pipeline in `rails_helper.rb`.

```ruby
# spec/rails_helper.rb
RSpec.configure do |config|
  config.before(:suite) do
    Webpack::Manifest.configure do |webpack|
      wepback.path = Rails.root.join('spec', 'fixtures', 'manifest.json')
    end
  end
end
```

## Manifest file format

```json
{
  "publicPath":"/assets/",
  "assetsByChunkName":{
    "application":[
      "24422e311f62ce2362a9.application.js",
      "24422e311f62ce2362a9.application.css"
    ],
    "orphus":"f380126f2ec17e439332.orphus.js",
    "vendors":"3dd62ef5da9412f1fe40.vendors.js"
  },
  "assets":{
    "favicon-195x195.png":"images/favicons/78f6baa138752eaba9e201a3f53e3c3b.favicon-195x195.png"
  }
}
```
