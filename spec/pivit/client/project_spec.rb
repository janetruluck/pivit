require "spec_helper"

# Client Spec
describe Pivit::Client do
  before do
    Pivit.reset!
  end

  describe ".project", :vcr do
    let!(:pivit) { Pivit::Client.new(:token => ENV["TOKEN"]) }
    let(:current_response) { pivit.project(ENV["PROJECT"]) }

    it "should return the project response" do
      current_response.should_not be_nil
      current_response.should respond_to(:name)
    end
  end

  describe ".projects", :vcr => {:cassette_name => "project/projects"} do
    let!(:pivit) { Pivit::Client.new(:token => ENV["TOKEN"]) }
    let(:current_response) { pivit.projects }

    it "should return an array of projects" do
      current_response.should be_a(Array)
      current_response.first.should respond_to(:account)
    end

    it "should return the projects" do
      current_response.should_not be_nil
    end
  end

  describe ".create_project", :type => :webmock do
    let!(:pivit) { Pivit::Client.new(:token => ENV["TOKEN"]) }
    let(:current_response) { pivit.create_project({:name => "Awesome Test Project", :iteration_length => 2, :point_scale => "0,1,2,3,4"}) }

    it "returns the project that was created" do
      stub_request(:post, "https://www.pivotaltracker.com/services/v3/projects?project%5Biteration_length%5D=2&project%5Bname%5D=Awesome%20Test%20Project&project%5Bpoint_scale%5D=0,1,2,3,4").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/project/project.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.should respond_to(:name)
    end

    it "returns the project that was created with the attributes provided" do
      stub_request(:post, "https://www.pivotaltracker.com/services/v3/projects?project%5Biteration_length%5D=2&project%5Bname%5D=Awesome%20Test%20Project&project%5Bpoint_scale%5D=0,1,2,3,4").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/project/project.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.name.should == "Cardassian War Plans"
    end

    it "should be a hashie" do
      stub_request(:post, "https://www.pivotaltracker.com/services/v3/projects?project%5Biteration_length%5D=2&project%5Bname%5D=Awesome%20Test%20Project&project%5Bpoint_scale%5D=0,1,2,3,4").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/project/project.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})
      
      current_response.should be_a(Hashie::Mash)
    end
  end
end
