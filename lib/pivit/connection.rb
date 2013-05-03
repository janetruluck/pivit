# Connection
require "faraday_middleware"

module Pivit
  module Connection
    def connection(options = {})
      options = {
        :ssl              => { :verify => false }
      }.merge(options)
  
      connection = Faraday.new(options) do |build|
        build.request :multipart
        build.request :url_encoded
        build.use FaradayMiddleware::Mashify
        build.use FaradayMiddleware::ParseXml,  :content_type => /\bxml$/
        build.adapter  Faraday.default_adapter
      end

      connection.headers["X-TrackerToken"] = api_token if self.authenticated?

      connection
    end
  end
end
