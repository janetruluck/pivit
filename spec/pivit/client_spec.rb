require "spec_helper"

# Client Spec
describe Pivit::Client do
  let(:username) { "someusername" }
  let(:password) { "someuserpassword" }
  let(:token) { "super_secret" }

  before do
    Pivit.reset!
  end

  describe "#initialize" do
    it "can be initialized" do
      Pivit::Client.new(:username => username, :password => password).class.should == Pivit::Client
    end

    it "is aliased within itself" do
      Pivit.new(:username => username, :password => password).class.should == Pivit::Client
    end

    it "works with basic username and password" do
      Pivit::Client.new(:username => username, :password => password)
      .should_not
      raise_exception
    end
    
    it "works with token" do
      Pivit::Client.new(:token=> token)
      .should_not
      raise_exception
    end

    it "can be configured to use a different ssl option via options" do
      client = Pivit::Client.new(:token => token, :ssl => false )
      client.ssl.should == false
    end

    it "raises an exception if the incorrect options are used" do
      lambda{ Pivit::Client.new(:broke => "broken") }.should raise_exception
    end

    context "authenticated" do
      let!(:client) { Pivit::Client.new(:username  => username, :password => password) }
    
      it "does not generate an endpoint with username and password" do
        client.api_endpoint.should_not include("#{username}:#{password}")
      end
    end
  end
end
