# notes

module Pivit
  class Client
    # Note management
    # 
    # @see http://www.pivotaltracker.com/help/api?version=v3#getting_notes
    module Note
      # Retrieve all notes for a story
      #
      # @param [Integer] project_id the id of the project that contains the notes
      # @param [Integer] story_id the id of the story that contains the notes
      #
      # @return [Hashie::Mash] notes response
      #
      # @example 
      #   Pivit::Client.notes(1111111, 222222)
      # 
      # @author Jason Truluck
      def notes(project_id, story_id, options = {})
        get("projects/#{project_id}/stories/#{story_id}/notes", options).notes
      end

      # Create a note
      # 
      # Provide the parameters you want to use for the note via the options
      # hash 
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#add_note
      #
      # @param [Integer] project_id the id of the project that contains the story
      # @param [Integer] story_id the id of the story that contains the note
      # @param [String] text the text that the story note will contain
      #
      # @return [Hashie::Mash] note created response
      #
      # @example 
      #   Pivit::Client.create_note(111111, 222222, "some not text")
      #
      # @author Jason Truluck
      def create_note(project_id, story_id, text, options = {})
        options = { :note => options.merge!(:text => text) }
        post("projects/#{project_id}/stories", options).note
      end
    end
  end
end
