# Authentication Module
module Pivit
  module Authentication
    def authenticated?
      !self.api_token.nil?
    end

    def authenticate(options)
      if !options[:username].nil? && !options[:password].nil?
        self.username  = URI::encode(options[:username])
        self.password  = URI::encode(options[:password])
        self.api_token = get("tokens/active").token.guid
        build_endpoint
      elsif !options[:token].nil?
        self.api_token = options[:token]
        build_endpoint
      else
        raise "Your authentication credentials are invalid."
      end 
    end
  end
end
