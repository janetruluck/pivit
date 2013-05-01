require "spec_helper"

# Activity Spec
describe Pivit::Client do
  before do
    Pivit.reset!
  end

  let!(:pivit) { Pivit::Client.new(:token => ENV["TOKEN"]) }

  describe ".activity", :vcr => {:cassette_name => "activity/activities"} do
    let(:current_response) { pivit.activity }

    it "returns an array of activities" do
      current_response.should be_a(Array)
    end

    it "returns the version" do
      current_response.each{ |x| x.should respond_to(:version) }
    end

    it "returns the activities" do
      current_response.should_not be_nil
    end
  end
end
