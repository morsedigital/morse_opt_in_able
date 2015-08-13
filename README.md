# MorseOptInAble

Adds marketing opt-in fields to ActiveRecord models

[![Coverage Status](https://coveralls.io/repos/morsedigital/morse_opt_in_able/badge.svg?branch=master&service=github)](https://coveralls.io/github/morsedigital/morse_opt_in_able?branch=master)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'morse_opt_in_able'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install morse_opt_in_able

## Usage

In your model:

```ruby
include OptInAble
```

It then provides you with the following BOOLEAN attributes

```ruby
   :allow_email
   :allow_mail
   :allow_sms
   :allow_phone
   :optin_marketing
   :optin_third_party
```

By default if you do Thing.new and you don't have the relevant fields in your database, it'll return a validtion error.

You can over-ride the required database fields in your Thing model by adding this ABOVE where you include OptInAble

```ruby
def required_database_fields
  [:allow_email] #choose from the above list to include only what you want
end
```

Also, you can over-ride the required attributes fields in your Thing model by adding this ABOVE where you include OptInAble

```ruby
def required_opt_in_able_attributes
  [:allow_email] #choose from the above list to include only what you want
end

So you can have all the columns in your database, but make a selection of them mandatory (the others will be optional)

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/morse_opt_in_able/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
