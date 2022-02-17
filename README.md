# XTF-Ruby

== Ruby Interface to XTF

=== Summary

XTF-Ruby brings a Ruby interface to the XTF framework. For searches, it allows you to use Ruby to generate XML queries for XTF's RawQuery servlet which then responds with XTF's raw XML response.

=== Status of Code

Currently, the search section of the library is robust and employed in a production environment. For results, XTF-Ruby provides an API for parsing XTF's raw XML results into Ruby objects. This area is currently a work-in-progress, as I extract the code from a project for generalized use.

In February of 2022 the old plugin was converted to a Ruby Gem, Specs were updated for RSpec ~>3 and improved, and a few small compatibility updates were made.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'xtf-ruby'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install xtf-ruby

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jamieorc/xtf-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/jamieorc/xtf-ruby/blob/gem-conversion/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [APACHE-2.0 License](https://opensource.org/licenses/Apache-2.0).

## Code of Conduct

Everyone interacting in the XTF::Ruby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/jamieorc/xtf-ruby/blob/gem-conversion/CODE_OF_CONDUCT.md).
