require "spec_helper"

# Membership Spec
describe Pivit::Client::Membership do
  before do
    Pivit.reset!
  end

  let!(:pivit) { Pivit::Client.new(:token=> ENV["TOKEN"]) }

  describe ".membership", :vcr => {:cassette_name => "membership/membership"} do
    let(:current_response) { pivit.membership(ENV["PROJECT"], ENV["membership"]) }

    it "should return the membership response" do
      current_response.should_not be_nil
    end

    it "should return the person of the membership" do
      current_response.should respond_to(:person)
    end

    it "should return the role of the membership" do
      current_response.should respond_to(:role)
    end
  end

  describe ".memberships", :vcr => {:cassette_name => "membership/memberships"} do
    let(:current_response) { pivit.memberships(ENV["PROJECT"]) }

    it "should return an array of memberships" do
      current_response.should be_a(Array)
      current_response.each{ |x| x.should respond_to(:person) }
    end

    it "should return the memberships" do
      current_response.should_not be_nil
    end
  end

  describe ".create_membership", :type => :webmock  do
    let(:current_response) { 
      pivit.create_membership(ENV["PROJECT"], "jason@woofound.com", "Member") 
    }

    it "returns the person of the membership that was created" do
      stub_request(:post, "https://www.pivotaltracker.com/services/v3/projects/795721/memberships?membership%5Bperson%5D%5Bemail%5D=jason@woofound.com&membership%5Brole%5D=Member").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/membership.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})
      current_response.should respond_to(:person)
    end

    it "returns the role of the membership that was created" do
      stub_request(:post, "https://www.pivotaltracker.com/services/v3/projects/795721/memberships?membership%5Bperson%5D%5Bemail%5D=jason@woofound.com&membership%5Brole%5D=Member").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/membership.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})
      current_response.should respond_to(:role)
    end

    it "should be a hashie" do
      stub_request(:post, "https://www.pivotaltracker.com/services/v3/projects/795721/memberships?membership%5Bperson%5D%5Bemail%5D=jason@woofound.com&membership%5Brole%5D=Member").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/membership.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})
      current_response.should be_a(Hashie::Mash)
    end
  end

  describe ".delete_membership", :type => :webmock do
    let(:current_response) { pivit.delete_membership(ENV["PROJECT"], ENV["MEMBERSHIP"]) }

    it "returns the membership that was deleted" do
      stub_request(:delete, "https://www.pivotaltracker.com/services/v3/projects/795721/memberships/534713").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/membership.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.id.should == 15007.to_s
    end

    it "should be a hashie" do
      stub_request(:delete, "https://www.pivotaltracker.com/services/v3/projects/795721/memberships/534713").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/membership.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.should be_a(Hashie::Mash)
    end
  end
end
