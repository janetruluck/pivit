#Client Module
require "pivit/authentication"
require "pivit/connection"
require "pivit/request"

require "pivit/client/activity"
require "pivit/client/iteration"
require "pivit/client/membership"
require "pivit/client/note"
require "pivit/client/project"
require "pivit/client/story"
require "pivit/client/task"

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

    include Pivit::Client::Activity
    include Pivit::Client::Iteration
    include Pivit::Client::Membership
    include Pivit::Client::Note
    include Pivit::Client::Project
    include Pivit::Client::Story
    include Pivit::Client::Task
  end
end
