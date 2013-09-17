require "spec_helper"

# Task Spec
describe Pivit::Client::Task do
  let!(:pivit) { Pivit::Client.new(:token => "super_secret") }
  let(:project_id) { 99 }
  let(:story_id) { 555 }
  let(:task_id) { 5 }

  before do
    Pivit.reset!
  end

  describe ".task" do
    let(:current_response) { pivit.task(project_id, story_id, task_id) }

    before(:each) do
      stub_pivotal(:get, "/projects/#{project_id}/stories/#{story_id}/tasks/#{task_id}", "story_task.json")
    end

    it "is not nil" do
      expect(current_response).to_not be_nil
    end

    it "returns the task requested" do
      expect(current_response.id).to eq(task_id)
    end
  end

  describe ".tasks" do
    let(:current_response) { pivit.tasks(project_id, story_id) }

    before(:each) do
      stub_pivotal(:get, "/projects/#{project_id}/stories/#{story_id}/tasks", "story_tasks.json")
    end

    it "is not nil" do
      expect(current_response).to_not be_nil
    end

    it "returns an array of tasks" do
      expect(current_response).to be_a(Array)
    end

    it "returns tasks" do
      current_response.each{|x| expect(x.kind).to eq("task") }
    end
  end

  describe ".create_task" do
    let(:description) { "port 270" }
    let(:current_response) { pivit.create_task(project_id, story_id, { :description => description })}

    before(:each) do
      stub_pivotal(:post, "/projects/#{project_id}/stories/#{story_id}/tasks?description=port%20270", "create_story_task.json")
    end

    it "is not nil" do
      expect(current_response).to_not be_nil
    end

    it "returns the description specified" do
      expect(current_response.description).to eq(description)
    end

    it "returns a hashie" do
      expect(current_response).to be_a(Hashie::Mash)
    end
  end

  describe ".update_task" do
    let(:description) { "port 360" }
    let(:current_response) { pivit.update_task(project_id, story_id, task_id, { :description => description })}

    before(:each) do
      stub_pivotal(:put, "/projects/#{project_id}/stories/#{story_id}/tasks/#{task_id}?description=port%20360", "update_story_task.json")
    end

    it "is not nil" do
      expect(current_response).to_not be_nil
    end

    it "returns the description specified" do
      expect(current_response.description).to eq(description)
    end

    it "returns a hashie" do
      expect(current_response).to be_a(Hashie::Mash)
    end
  end

  describe ".delete_task" do
    before(:each) do
      stub_pivotal(:delete, "/projects/#{project_id}/stories/#{story_id}/tasks/#{task_id}", "empty.json")
    end

    it "makes a request to delete the task" do
      pivit.delete_task(project_id, story_id, task_id)
      expect(WebMock).to have_requested(:delete, "http://www.pivotaltracker.com/services/v5/projects/99/stories/555/tasks/5").once
    end
  end
end
