require "spec_helper"

# Story Spec
describe Pivit::Client::Story do
  let!(:pivit) { Pivit::Client.new(:token => "super_secret") }
  let(:project_id) { 99 }
  let(:story_id) { 555 }

  before do
    Pivit.reset!
  end

  describe ".story" do
    let(:current_response) { pivit.story(project_id, story_id) }

    before(:each) do
      stub_pivotal(:get, "/projects/99/stories/555", "story.json", 200)
    end

    it "should return the story response" do
      expect(current_response).not_to be_nil
    end

    it "is of kind story" do
      expect(current_response.kind).to eq("story")
    end

    it "is from the requested project" do
      expect(current_response.project_id).to eq(project_id)
    end

    it "is the requested story" do
      expect(current_response.id).to eq(story_id)
    end
  end

  describe ".stories" do
    let(:current_response) { pivit.stories(project_id) }

    before(:each) do
      stub_pivotal(:get, "/projects/99/stories", "stories.json", 200)
    end

    it "should return the stories" do
      expect(current_response).not_to be_nil
    end

    it "returns an array of stories" do
      current_response.each{|x| expect(x.kind).to eq("story") }
    end

    it "is of type Array" do
      expect(current_response).to be_a(Array)
    end
  end

  describe ".create_story" do
    let(:name) { "Exhaust ports are ray shielded" }
    let(:story_type) { "feature" }
    let(:current_response) { 
      pivit.create_story(
        project_id, 
        {
          :name => name,
          :story_type => story_type
        }
      ) 
    }

    before(:each) do
      stub_pivotal(:post, "/projects/99/stories?name=Exhaust%20ports%20are%20ray%20shielded&story_type=#{story_type}", "create_story.json")
    end

    it "is created with the story_type provided" do
      expect(current_response.story_type).to eq(story_type)
    end

    it "is created with the name provided" do
      expect(current_response.name).to eq(name)
    end

    it "should be a hashie" do
      expect(current_response).to be_a(Hashie::Mash)
    end
  end

  describe ".update_story" do
    let(:name) { "Bring me the passengers" }
    let(:current_response) { 
      pivit.update_story(
        project_id, 
        story_id,
        {
          :name => name
        }
      ) 
    }

    before(:each) do
      stub_pivotal(:put, "/projects/99/stories/555?name=Bring%20me%20the%20passengers", "update_story.json")
    end

    it "is updated with the name provided" do
      expect(current_response.name).to eq(name)
    end

    it "should be a hashie" do
      expect(current_response).to be_a(Hashie::Mash)
    end
  end

  context "## DEPRECEATED ##" do
    describe ".move_story_before", :type => :webmock do
      let(:current_response) { pivit.move_story_before(project_id, story_id, 11) }

      before(:each) do
        stub_pivotal(:put, "/projects/99/stories/555?before_id=11", "update_story.json")
      end

      it "returns the story that was moved" do
        expect(current_response.id).to eq(story_id)
      end

      it "should be a hashie" do
        expect(current_response).to be_a(Hashie::Mash)
      end
    end

    describe ".move_story_after", :type => :webmock do
      let(:current_response) { pivit.move_story_after(project_id, story_id, 11) }

      before(:each) do
        stub_pivotal(:put, "/projects/99/stories/555?after_id=11", "update_story.json")
      end

      it "returns the story that was moved" do
        expect(current_response.id).to eq(story_id)
      end

      it "should be a hashie" do
        expect(current_response).to be_a(Hashie::Mash)
      end
    end
  end

  describe ".add_attachment" do
    let(:file_path) { File.path(File.expand_path("../../../support/test.png", __FILE__)) }
    let(:current_response) { 
      pivit.add_attachment(
        project_id, 
        story_id, 
        file_path
      )
    }

    before(:each) do
      stub_pivotal(:post, "/projects/99/stories/555/attachments?file_name=#{file_path}", "update_story_attachement.json")
    end

    it "is not nil" do
      expect(current_response).to_not be_nil
    end
    
    it "adds the attachment to the story" do
      expect(current_response.comments.first.file_attachments).to_not be_empty
    end
  end
end
