# lib/client/story.rb
module Pivit
  class Client
    # Story management
    # 
    # @see https://www.pivotaltracker.com/help/api/rest/v5#Story
    # @see https://www.pivotaltracker.com/help/api/rest/v5#Stories
    # @see https://www.pivotaltracker.com/help/api/rest/v5#Story_Tasks
    module Story
      # Retrieve a single story from your account
      #
      # @see https://www.pivotaltracker.com/help/api/rest/v5#projects_project_id_stories_story_id_get
      #
      # @param [Integer] project_id the id of the project that you want to retrieve stories from
      # @param [Integer] story_id the id of the story that you want to retrieve
      #
      # @return [Hashie::Mash] story response
      #
      # @example 
      #   Pivit::Client.story(1111111, 123456)
      #
      # @author Jason Truluck
      def story(project_id, story_id, options = {})
        get("projects/#{project_id}/stories/#{story_id}", options)
      end
      # Retrieve all stories from your account
      #
      # @see https://www.pivotaltracker.com/help/api/rest/v5#projects_project_id_stories_get
      #
      # You can also use any filter option provided by pivotal tracker by
      # prefacing with the option :filter
      #
      # @param [Integer] project_id the id of the project that contains the stories
      #
      # @return [Hashie::Mash] stories response
      #
      # @example 
      #   Pivit::Client.stories(1111111)
      #
      #   Pivit::Client.stories(1111111, {:filter => "type:bug,chore"})
      # 
      # @author Jason Truluck
      def stories(project_id, options = {})
        get("projects/#{project_id}/stories", options)
      end
      # Create a story
      # 
      # Provide the parameters you want to use for the story via the options hash 
      #
      # @see https://www.pivotaltracker.com/help/api/rest/v5#projects_project_id_stories_post
      #
      # @param [Integer] project_id the id of the project that contains the story
      #
      # @return [Hashie::Mash] story created response
      #
      # @example 
      #   Pivit::Client.create_story({:type => "feature", :name => "Story"})
      #
      # @author Jason Truluck
      def create_story(project_id, options = {})
        post("projects/#{project_id}/stories", options)
      end
      # Update a story
      # 
      # Provide the parameters you want to use for the story via the options
      # hash 
      #
      # @see https://www.pivotaltracker.com/help/api/rest/v5#projects_project_id_stories_story_id_put 
      #
      # @param [Integer] project_id the id of the project that contains the story
      # @param [Integer] story_id the id of the story that is getting updated
      #
      # @return [Hashie::Mash] story updated response
      #
      # @example 
      #   Pivit::Client.update_story(12345, 11111, {:name => "awesome new story name"})
      #
      # @author Jason Truluck
      def update_story(project_id, story_id, options = {})
        put("projects/#{project_id}/stories/#{story_id}",  options)
      end
    
      # Delete a story
      #
      # @see https://www.pivotaltracker.com/help/api/rest/v5#projects_project_id_stories_story_id_delete
      #
      # @param [Integer] project_id the id of the project that contains the story
      # @param [Integer] story_id the id of the story that is getting deleted
      #
      # @return [Hashie::Mash] story deleted response
      #
      # @example 
      #   Pivit::Client.delete_story(12345, 11111)
      ##
      # @author Jason Truluck
      def delete_story(project_id, story_id, options = {})
        delete("projects/#{project_id}/stories/#{story_id}", options)
      end
     
      # Move a story before another story
      #
      # @depreceated Please use {update_story} instead since this has been
      # rolled into available options
      #
      # @see https://www.pivotaltracker.com/help/api/rest/v5#projects_project_id_stories_story_id_put
      #
      # @param [Integer] project_id the id of the project that contains the story
      # @param [Integer] story_id the id of the story that is getting moved
      # @param [Integer] story_target_id the id of the story that the other story is moving before
      #
      # @return [Hashie::Mash] story move response
      #
      # @example 
      #   Pivit::Client.move_story_before(12345, 11111, 22222)
      ##
      # @author Jason Truluck
      def move_story_before(project_id, story_id, story_target_id, options = {})
        options.merge!({:before_id => story_target_id})
        update_story(project_id, story_id, options)
      end
      
      # Move a story after another story
      #
      # @depreceated Please use {update_story} instead since this has been
      # rolled into available options
      #
      # @see https://www.pivotaltracker.com/help/api/rest/v5#projects_project_id_stories_story_id_put
      #
      # @param [Integer] project_id the id of the project that contains the story
      # @param [Integer] story_id the id of the story that is getting moved
      # @param [Integer] story_target_id the id of the story that the other story is moving after
      #
      # @return [Hashie::Mash] story move response
      #
      # @example 
      #   Pivit::Client.move_story_after(12345, 11111, 22222)
      ##
      # @author Jason Truluck
      def move_story_after(project_id, story_id, story_target_id, options = {})
        options.merge!({:after_id => story_target_id})
        update_story(project_id, story_id, options)
      end

      # Add an attachement to a story
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#attachements
      #
      # @param [Integer] project_id the id of the project that contains the story
      # @param [Integer] story_id the id of the story that is getting moved
      # @param [String] file the location of the file to be attached
      #
      # @return [Hashie::Mash] story attachement response
      #
      # @example 
      #   Pivit::Client.add_attachment(12345, 111111, "test.txt")
      ##
      # @author Jason Truluck
      def add_attachment(project_id, story_id, file, options = {})
        options.merge!(:file_name => file)
        post("projects/#{project_id}/stories/#{story_id}/attachments", options)
      end
    end
  end
end
