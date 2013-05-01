require "spec_helper"

# Task Spec
describe Pivit::Client::Task do
  before do
    Pivit.reset!
  end

  let!(:pivit) { Pivit::Client.new(:token=> ENV["TOKEN"]) }

  describe ".task", :vcr => {:cassette_name => "task/task"} do
    let(:current_response) { pivit.task(ENV["PROJECT"], ENV["STORY"], ENV["TASK"]) }

    it "return the task response" do
      current_response.should_not be_nil
    end

    it "responds to description" do
      current_response.should respond_to(:description)
    end
  end

  describe ".tasks", :vcr => {:cassette_name => "task/tasks"} do
    let(:current_response) { pivit.tasks(ENV["PROJECT"], ENV["STORY"]) }

    it "should return an array of tasks" do
      current_response.should be_a(Array)
    end

    it "responds to description" do
      current_response.each{|x|  x.should respond_to(:description) }
    end

    it "should return the tasks" do
      current_response.should_not be_nil
    end
  end

  describe ".create_task", :type => :webmock do
    let(:description) { "find shields" }
    let(:current_response) { pivit.create_task(ENV["PROJECT"], ENV["STORY"], { :description => description })}

    it "returns the task that was created" do
      stub_request(:post, "https://www.pivotaltracker.com/services/v3/projects/795721/stories/48859617/tasks?task%5Bdescription%5D=find%20shields").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/task.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.should respond_to(:description)
    end

    it "returns the description specified" do
      stub_request(:post, "https://www.pivotaltracker.com/services/v3/projects/795721/stories/48859617/tasks?task%5Bdescription%5D=find%20shields").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/task.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.description.should == description
    end

    it "should be a hashie" do
      stub_request(:post, "https://www.pivotaltracker.com/services/v3/projects/795721/stories/48859617/tasks?task%5Bdescription%5D=find%20shields").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/task.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.should be_a(Hashie::Mash)
    end
  end

  describe ".update_task", :type => :webmock do
    let(:description) { "awesome new description" }
    let(:current_response) { pivit.update_task(ENV["PROJECT"], ENV["STORY"], ENV["TASK"], { :description => description })}

    it "returns the task that was update" do
      stub_request(:put, "https://www.pivotaltracker.com/services/v3/projects/795721/stories/48859617/tasks/14216257?task%5Bdescription%5D=awesome%20new%20description").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/task_update.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.should respond_to(:description)
    end

    it "updates the attributes specified" do
      stub_request(:put, "https://www.pivotaltracker.com/services/v3/projects/795721/stories/48859617/tasks/14216257?task%5Bdescription%5D=awesome%20new%20description").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/task_update.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.description.should == description
    end

    it "should be a hashie" do
      stub_request(:put, "https://www.pivotaltracker.com/services/v3/projects/795721/stories/48859617/tasks/14216257?task%5Bdescription%5D=awesome%20new%20description").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/task_update.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.should be_a(Hashie::Mash)
    end
  end

  describe ".delete_task", :type => :webmock do
    let(:current_response) { pivit.delete_task(ENV["PROJECT"], ENV["STORY"], ENV["TASK"]) }

    it "returns the task that was deleted" do
       stub_request(:delete, "https://www.pivotaltracker.com/services/v3/projects/795721/stories/48859617/tasks/14216257").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/task.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.id.should == ENV["TASK"].to_i
    end

    it "should be a hashie" do
       stub_request(:delete, "https://www.pivotaltracker.com/services/v3/projects/795721/stories/48859617/tasks/14216257").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/task.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.should be_a(Hashie::Mash)
    end
  end
end
