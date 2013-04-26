require "spec_helper"

# Client Spec
describe Pivit::Client do
  before do
    Pivit.reset!
  end

  describe ".project", :vcr do
    let!(:pivit) { Pivit::Client.new(:username => ENV["USERNAME"], :password => ENV["PASSWORD"]) }
    let(:current_response) { pivit.project(ENV["PROJECT"]) }

    it "should return the project response" do
      current_response.should_not be_nil
      current_response.should respond_to(:name)
    end
  end

  describe ".projects", :vcr => {:cassette_name => "project/projects"} do
    let!(:pivit) { Pivit::Client.new(:username => ENV["USERNAME"], :password => ENV["PASSWORD"]) }
    let(:current_response) { pivit.projects }

    it "should return an array of projects" do
      current_response.should be_a(Array)
      current_response.first.should respond_to(:account)
    end

    it "should return the projects" do
      current_response.should_not be_nil
    end
  end


  describe ".add_project", :vcr => {:cassette_name => "project/add_project"} do
    let!(:pivit) { Pivit::Client.new(:username => ENV["USERNAME"], :password => ENV["PASSWORD"]) }
    let(:current_response) { pivit.add_project({:name => "Awesome Test Project", :iteration_length => 2, :point_scale => "0,1,2,3,4"}) }

    it "returns the project that was created" do
      current_response.should respond_to(:name)
    end

    it "should be a hashie" do
      current_response.should be_a(Hashie::Mash)
    end

    context "failed request", :vcr do
      let(:current_response) { pivit.add_project({:with_query_params => false, :name => "Awesome Test Project", :iteration_length => 2, :point_scale => "0,1,2,3,4"}) }

      it "returns the error message" do
        current_response.should == "Project parameter required"
      end
    end
  end
end
