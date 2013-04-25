#Client Module
require "pivit/authentication"
require "pivit/connection"
require "pivit/request"

module Pivit
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS_KEYS)

    def initialize(options = {})
      options = Pivit.options.merge(options)

      Configuration::VALID_OPTIONS_KEYS.each do |key|
        send("#{key}=", options[key])
      end

      authenticate(options)
    end

    include Pivit::Authentication
    include Pivit::Connection
    include Pivit::Request
  end
end
