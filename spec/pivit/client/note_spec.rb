require "spec_helper"

# note Spec
describe Pivit::Client::Note do
  before do
    Pivit.reset!
  end

  let!(:pivit) { Pivit::Client.new(:token=> ENV["TOKEN"]) }

  describe ".notes", :vcr => {:cassette_name => "note/notes"} do
    let(:current_response) { pivit.notes(ENV["PROJECT"], ENV["STORY"]) }

    it "return an array of notes" do
      current_response.should be_a(Array)
    end
    
    it "return the notes" do
      current_response.should_not be_nil
    end
    
    it "returns the text of the note" do
      current_response.each{ |x| x.should respond_to(:text) }    
    end
  end

  describe ".create_note", :type => :webmock do
    let(:current_response) { pivit.create_note(ENV["PROJECT"], ENV["STORY"], ENV["NOTE"]) }

    it "returns the note that was created" do
      stub_request(:post, "https://www.pivotaltracker.com/services/v3/projects/795721/stories?note%5Btext%5D=This%20is%20some%20note%20text").
        to_return(:status => 200, 
                  :body => File.open(File.expand_path("../../../fixtures/stubs/note.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.should respond_to(:text)
    end

    it "be a hashie" do
      stub_request(:post, "https://www.pivotaltracker.com/services/v3/projects/795721/stories?note%5Btext%5D=This%20is%20some%20note%20text").
        to_return(:status => 200, 
                  :body => File.open(File.expand_path("../../../fixtures/stubs/note.xml", __FILE__)),
                  :headers => {'Accept' => 'application/xml', 'Content-type' => 'application/xml',})

      current_response.should be_a(Hashie::Mash)
    end
  end
end
