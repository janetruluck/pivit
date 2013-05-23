require 'rubygems'

# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

if ENV['RAILS_ENV'] == 'test'
  require 'simplecov'
  SimpleCov.start 'rails'
  class SimpleCov::Formatter::QualityFormatter
    def format(result)
      SimpleCov::Formatter::HTMLFormatter.new.format(result)
      File.open("coverage/covered_percent", "w") do |f|
        f.puts result.source_files.covered_percent.to_f
      end
    end
  end
  SimpleCov.formatter = SimpleCov::Formatter::QualityFormatter
end

require 'pivit'
require 'vcr'
require 'webmock/rspec'
require "mocha/api"

authentications = File.expand_path("../fixtures/authentications.yml", __FILE__)
if File.exists?(authentications)
  ENV.update YAML::load(File.open(authentications))
end

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :faraday
  c.configure_rspec_metadata!
end

Dir[File.expand_path("spec/support/**/*.rb", __FILE__)].each {|f| require f}

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.order                                           = "random"
  config.color_enabled                                   = true

  config.before :type => :webmock do
    WebMock.disable_net_connect!
    VCR.turn_off!
  end

  config.after :type => :webmock do
    WebMock.allow_net_connect!
    VCR.turn_on!
  end
end
