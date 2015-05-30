require 'bundler/setup'

Bundler.setup(:default, :extra)

require 'coveralls'
Coveralls.wear!

require 'cellcom'

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.order                            = 'random'
end
