require "spec_helper"

# Story Spec
describe Pivit::Client::Story do
  before do
    Pivit.reset!
  end

  let!(:pivit) { Pivit::Client.new(:token=> ENV["TOKEN"]) }

  describe ".story", :vcr do
    let(:current_response) { pivit.story(ENV["PROJECT"], ENV["STORY"]) }

    it "should return the story response" do
      current_response.should_not be_nil
      current_response.should respond_to(:name)
    end
  end

  describe ".stories", :vcr => {:cassette_name => "story/stories"} do
    let(:current_response) { pivit.stories(ENV["PROJECT"]) }

    it "should return an array of stories" do
      current_response.should be_a(Array)
      current_response.first.should respond_to(:current_state)
    end

    it "should return the stories" do
      current_response.should_not be_nil
    end
  end

  describe ".create_story", :vcr => {:cassette_name => "story/create_story"} do
    let(:current_response) { 
      pivit.create_story(ENV["PROJECT"], 
                      {
                        :name => "Awesome Test story",
                        :story_type =>"feature"
                      }) 
    }

    it "returns the story that was created" do
      current_response.should respond_to(:name)
    end

    it "should be a hashie" do
      current_response.should be_a(Hashie::Mash)
    end
  end

  describe ".update_story", :vcr => {:cassette_name => "story/update_story"} do
    let(:name) { "awesome new name" }
    let(:current_response) {  
      pivit.update_story(ENV["PROJECT"], 
                         ENV["STORY"],
                        {
                          :name => name
                        }) 
    }

    it "returns the story that was update" do
      current_response.should respond_to(:name)
    end

    it "updates the attributes specified" do
      current_response.name.should == name
    end

    it "should be a hashie" do
      current_response.should be_a(Hashie::Mash)
    end
  end

  describe ".delete_story", :type => :webmock do
    let(:current_response) { pivit.delete_story(ENV["PROJECT"], ENV["STORY"]) }

    it "returns the story that was deleted" do
      stub_request(:delete, "https://www.pivotaltracker.com/services/v3/projects/795721/stories/48859617").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/story/delete_story.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.id.should == ENV["STORY"].to_i
    end

    it "should be a hashie" do
      stub_request(:delete, "https://www.pivotaltracker.com/services/v3/projects/795721/stories/48859617").
        to_return(:status => 200,
                  :body => File.open(File.expand_path("../../../fixtures/stubs/story/delete_story.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.should be_a(Hashie::Mash)
    end
  end

  describe ".move_story_before", :type => :webmock do
    let(:current_response) { pivit.move_story_before(ENV["PROJECT"], ENV["STORY"], ENV["STORY_B"]) }

    it "returns the story that was moved" do
      stub_request(:post, "https://www.pivotaltracker.com/services/v3/projects/795721/stories/48859617/moves?move%5Bmove%5D=before&move%5Btarget%5D=47998079").
        to_return(:status => 200, 
                  :body => File.open(File.expand_path("../../../fixtures/stubs/story/delete_story.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.id.should == ENV["STORY"].to_i
    end

    it "should be a hashie" do
      stub_request(:post, "https://www.pivotaltracker.com/services/v3/projects/795721/stories/48859617/moves?move%5Bmove%5D=before&move%5Btarget%5D=47998079").
        to_return(:status => 200, 
                  :body => File.open(File.expand_path("../../../fixtures/stubs/story/delete_story.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.should be_a(Hashie::Mash)
    end
  end

  describe ".move_story_after", :type => :webmock do
    let(:current_response) { pivit.move_story_after(ENV["PROJECT"], ENV["STORY"], ENV["STORY_B"]) }

    it "returns the story that was moved" do
      stub_request(:post, "https://www.pivotaltracker.com/services/v3/projects/795721/stories/48859617/moves?move%5Bmove%5D=after&move%5Btarget%5D=47998079").
        to_return(:status => 200, 
                  :body => File.open(File.expand_path("../../../fixtures/stubs/story/delete_story.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.id.should == ENV["STORY"].to_i
    end

    it "should be a hashie" do
      stub_request(:post, "https://www.pivotaltracker.com/services/v3/projects/795721/stories/48859617/moves?move%5Bmove%5D=after&move%5Btarget%5D=47998079").
        to_return(:status => 200, 
                  :body => File.open(File.expand_path("../../../fixtures/stubs/story/delete_story.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.should be_a(Hashie::Mash)
    end
  end

  describe ".add_attachment", :vcr => {:cassette_name => "story/attachment"} do
    let(:current_response) { 
      pivit.add_attachment(
        ENV["PROJECT"], 
        ENV["STORY"], 
        File.path(File.expand_path(ENV["FILE"], __FILE__))) 
    }
    
    it "adds the attachment to the story" do
      current_response.should_not be_nil
    end

    it "returns the status is pending" do
      current_response.status.should == "Pending"
    end
  end
end
