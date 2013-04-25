require 'multi_json'

module Pivit
  module Request
    def get(path, options = {})
      response = request(:get, path, options)
      response.body
    end

    def post(path, options = {})
      response = request(:post, path, options)
      response
    end

    # Builds the api endpoint to reach the Pivotal Api
    #
    # @return [String] Endpoint
    #
    # @author Jason Truluck
    def build_endpoint
      endpoint = ssl || self.api_token.nil? ? "https://" : "http://"
      endpoint << "#{self.username}:#{self.password}@" unless self.authenticated?
      endpoint << "www.pivotaltracker.com/services/v3/"
      self.api_endpoint = endpoint
    end

    private
    def request(method, path, options = {})
      url = options.delete(:endpoint) || build_endpoint

      connection_options = {
        :url => url
      }

      response = connection(connection_options).send(method) do |request|
        case method
        when :get
          request.url(path, options)
        when :post
          with_query_params = options.delete(:with_query_params) || false
          if with_query_params
            request.url(path, options)
          else
            request.path = path
            request.body = MultiJson.dump(options) unless options.empty?
          end
        end
      end
      response
    end
  end
end
