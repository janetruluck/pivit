require "spec_helper"

# Configuration Spec
describe Pivit::Client do
  describe "configuration" do
    # SSL
    describe "with a ssl", :vcr do
      let(:ssl)       { false }
      let(:client) {
        Pivit::Client.new(:username => ENV["USERNAME"], :password => ENV["PASSWORD"]) 
      }

      before do
        Pivit.reset!
        Pivit.configure do |c|
          c.ssl = ssl
        end
      end

      it "sets the ssl for the client" do
        client.ssl.should == ssl
      end

      it "builds an endpoint with the ssl set to false" do
        client.api_endpoint.should include("http://")
      end
    end
  end
end
