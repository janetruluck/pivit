require "spec_helper"

# Client Spec
describe Pivit::Client do
  let!(:pivit) { Pivit::Client.new(:token => "super_secret") }

  before(:each) do
    Pivit.reset!
  end

  describe ".project" do
    let(:current_response) { pivit.project(99) }

    before(:each) do
      stub_pivotal(:get, "/projects/99", "project.json", 200)
    end

    it "returns the project response" do
      expect(current_response).not_to be_nil
    end

    it "is a project" do
      expect(current_response.kind).to eq("project")
    end

    it "is the same project as requested" do
      expect(current_response.id).to eq(99)
    end
  end

  describe ".projects" do
    let(:current_response) { pivit.projects }

    before(:each) do
      stub_pivotal(:get, "/projects", "projects.json", 200)
    end

    it "returns an array" do
      expect(current_response).to be_a(Array)
    end

    it "returns an array of projects" do
      current_response.each{|x| expect(x.kind).to eq("project") }
    end
  end

  describe ".create_project" do
    let(:iteration_length) { 2 }
    let(:point_scale) { "0,1,2,3,4" }
    let(:current_response) { 
      pivit.create_project({:name => "Awesome Test Project", :iteration_length => iteration_length, :point_scale => point_scale} ) 
    }

    before(:each) do
      stub_pivotal(:post, "/projects?project%5Biteration_length%5D=#{iteration_length}&project%5Bname%5D=Awesome%20Test%20Project&project%5Bpoint_scale%5D=#{point_scale}", "create_project.json", 200)
    end

    it "returns the project that was created" do
      expect(current_response).to respond_to(:name)
    end

    it "creates the project with the specified iteration lenght" do
      expect(current_response.iteration_length).to eq(iteration_length)
    end

    it "creates the project with the specified point scale" do
      expect(current_response.point_scale).to eq(point_scale)
    end

    it "should be a hashie" do
      expect(current_response).to be_a(Hashie::Mash)
    end
  end
end
