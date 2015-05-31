# Cellcom

[![Build](https://travis-ci.org/gregory/cellcom.png?branch=master)](https://travis-ci.org/gregory/cellcom)
[![Code Climate](https://codeclimate.com/github/gregory/cellcom/badges/gpa.svg)](https://codeclimate.com/github/gregory/cellcom)
[![Coverage Status](https://coveralls.io/repos/gregory/cellcom/badge.svg?branch=master)](https://coveralls.io/r/gregory/cellcom?branch=master)

Cellcom is a ruby wrapper around the [Cellcom](https://www.cellcom.eu/en/) [HTTP API Spec](http://www.cellcom.be/documenten/Technical%20Specification%20HTTP%20gateway%20v8.pdf).

## NOTE

This is a minimal implementation that will just send the sms. In the futur, I(or you) will
add the ability to register a callback url for sms status and credit lookup.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cellcom'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cellcom

## Usage

```rb
Cellcom::Configure do |config|
  config.clid = 12345
  config.gwid = 123
  config.pwd  = "256ea978c8f8752eaf87e7a"
end

Cellcom::Sms.new(m: 'my message', to: '32496233133', sid: '3228886991').deliver
```

If for some reason you want to send from multiple accounts:

```rb
credentials_hash = {
  clid: 12345,
  gwid: 123,
  pwd : "256ea978c8f8752eaf87e7a"
}
Cellcom::Client.new(credentials_hash).deliver(m: 'my message', to: '32496233133', sid: '3228886991')

# or

sms = Cellcom::Sms.new(m: 'my message', to: '32496233133', sid: '3228886991')
client = Cellcom::Client.new(clid: 12345, gwid: 123, pwd : "256ea978c8f8752eaf87e7a")
sms.deliver(client)

```

## Contributing

1. Fork it ( https://github.com/gregory/cellcom/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
