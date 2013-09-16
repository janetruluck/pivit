module Pivit
  module Request
    def get(path, options = {})
      response = request(:get, path, options)
      response.body
    end

    def post(path, options = {})
      request(:post, path, options).body
    end

    def put(path, options={})
      request(:put, path, options).body
    end

    def delete(path, options={})
      request(:delete, path, options).body
    end

    # Builds the api endpoint to reach the Pivotal Api
    # the api endpoint to reach the Pivotal Api
    #
    # @return [String] Endpoint
    #
    # @author Jason Truluck
    def build_endpoint
      endpoint = self.ssl ? "https://" : "http://"
      endpoint << "#{self.username}:#{self.password}@" unless self.authenticated?
      endpoint << "www.pivotaltracker.com/services/v5/"
      self.api_endpoint = endpoint
    end

    private
    def request(method, path, options = {})
      url     = options.delete(:endpoint) || build_endpoint
      payload = options.delete(:payload)  || nil
      payload = Faraday::UploadIO.new(payload, "application/octet-stream") unless payload.nil?

      connection_options = {}.merge!(:url => url)

      response = connection(connection_options).send(method) do |request|
        case method
        when :get
          request.url(path, options)
        when :post, :put
          request.url(path, options)
          request.body = { :Filedata => payload } unless payload.nil?
        when :delete
          request.url(path, options)
        end
      end

      response
    end
  end
end
