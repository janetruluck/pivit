require "spec_helper"

# Client Spec
describe Pivit::Client do
  before do
    Pivit.reset!
  end
  let!(:pivit) { Pivit::Client.new(:token => ENV["TOKEN"]) }

  describe ".iterations", :vcr => {:cassette_name => "iteration/iterations"} do
    let(:current_response) { pivit.iterations(ENV["PROJECT"]) }

    it "returns a array of projects" do
      current_response.should be_a(Array)
    end

    it "responds to iteration" do
      current_response.each{ |x| x.should respond_to(:stories) }
    end 

    it "returns the iterations" do
      current_response.should_not be_nil
    end
  end

  describe ".done_iterations", :type => :webmock  do
    let(:current_response) { pivit.done_iterations(ENV["PROJECT"]) }

    it "returns a array of projects" do
      stub_request(:get, "https://www.pivotaltracker.com/services/v3/projects/795721/iterations/done").
        to_return(:status => 200, 
                  :body => File.open(File.expand_path("../../../fixtures/stubs/iteration.xml", __FILE__)),
                  :headers => {"Accept" => "application/xml", "Content-type" => "application/xml"})

      current_response.should be_a(Array)
    end

    it "responds to iteration" do
      stub_request(:get, "https://www.pivotaltracker.com/services/v3/projects/795721/iterations/done").
        to_return(:status => 200, 
                  :body => File.open(File.expand_path("../../../fixtures/stubs/iteration.xml", __FILE__)),
                  :headers => {"Accept" => "application/xml", "Content-type" => "application/xml"})

      current_response.each{ |x| x.should respond_to(:stories) }
    end 

    it "returns the iterations" do
      stub_request(:get, "https://www.pivotaltracker.com/services/v3/projects/795721/iterations/done").
        to_return(:status => 200, 
                  :body => File.open(File.expand_path("../../../fixtures/stubs/iteration.xml", __FILE__)),
                  :headers => {"Accept" => "application/xml", "Content-type" => "application/xml"})

      current_response.should_not be_nil
    end
  end

  describe ".iteration_backlog", :vcr => {:cassette_name => "iteration/iteration_backlog"} do
    let(:current_response) { pivit.iteration_backlog(ENV["PROJECT"]) }

    it "returns a array of projects" do
      current_response.should be_a(Array)
    end

    it "responds to iteration" do
      current_response.each{ |x| x.should respond_to(:stories) }
    end 

    it "returns the iterations" do
      current_response.should_not be_nil
    end
  end

  describe ".iteration_current", :vcr => {:cassette_name => "iteration/iteration_current"} do
    let(:current_response) { pivit.iteration_current(ENV["PROJECT"]) }

    it "returns a array of projects" do
      current_response.should be_a(Array)
    end

    it "responds to iteration" do
      current_response.each{ |x| x.should respond_to(:stories) }
    end 

    it "returns the iterations" do
      current_response.should_not be_nil
    end
  end

  describe ".iteration_current_and_backlog", :vcr => {:cassette_name => "iteration/iteration_current_and_backlog"} do
    let(:current_response) { pivit.iteration_current_and_backlog(ENV["PROJECT"]) }

    it "returns a array of projects" do
      current_response.should be_a(Array)
    end

    it "responds to iteration" do
      current_response.each{ |x| x.should respond_to(:stories) }
    end 

    it "returns the iterations" do
      current_response.should_not be_nil
    end
  end
end
