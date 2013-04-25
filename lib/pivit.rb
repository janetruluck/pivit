require "pivit/version"
require "pivit/configuration"
require "pivit/client"
require "pivit/error"

module Pivit
  extend Configuration

  class << self
    # Alias for Pivit::Client.new
    # @return [Pivit::Client]
    def new(options = {})
      Pivit::Client.new(options)
    end

    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
