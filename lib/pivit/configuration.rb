#Configuration
module Pivit
  module Configuration
    VALID_OPTIONS_KEYS = [
      :username,
      :password,
      :api_token,
      :api_endpoint,
      :ssl
    ]

    attr_accessor(*VALID_OPTIONS_KEYS)

    def configure
      yield self
    end

    def options
      VALID_OPTIONS_KEYS.inject({}){|o,k| o.merge!(k => send(k)) }
    end

    def reset!
      self.username            = nil
      self.password            = nil
      self.api_token           = nil
      self.ssl                 = true
    end
  end
end
