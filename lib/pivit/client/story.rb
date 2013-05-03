# Stories

module Pivit
  class Client
    # Story management
    # 
    # @see http://www.pivotaltracker.com/help/api?version=v3#getting_stories
    module Story
      # Retrieve a single story from your account
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#getting_stories
      #
      # @param [Integer] project_id the id of the project that you want to
      # retrieve stories from
      # @param [Integer] story_id the id of the story that you want to
      # retrieve
      #
      # @param [Integer] project_id the id of the project that contains the
      # story
      #
      # @return [Hashie::Mash] story response
      #
      # @example 
      #   Pivit::Client.story(1111111, 123456)
      #
      # @author Jason Truluck
      def story(project_id, story_id, options = {})
        get("projects/#{project_id}/stories/#{story_id}", options).story
      end

      # Retrieve all stories from your account
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#getting_stories
      #
      # @param [Integer] project_id the id of the project that contains the
      #stories
      #
      # @return [Hashie::Mash] stories response
      #
      # @example 
      #   Pivit::Client.stories(1111111)
      # 
      # @author Jason Truluck
      def stories(project_id, options = {})
        get("projects/#{project_id}/stories/", options).stories
      end

      # Create a story
      # 
      # Provide the parameters you want to use for the story via the options
      # hash 
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#add_story
      #
      # @param [Integer] project_id the id of the project that contains the
      # story
      #
      # @return [Hashie::Mash] story created response
      #
      # @example 
      #   Pivit::Client.create_story_type=> "feature", :name => "Story"})
      #
      # @author Jason Truluck
      def create_story(project_id, options = {})
        options = { :story => options }
        post("projects/#{project_id}/stories", options).story
      end

      # Update a story
      # 
      # Provide the parameters you want to use for the story via the options
      # hash 
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#update_story
      #
      # @param [Integer] project_id the id of the project that contains the
      # story
      # @param [Integer] story_id the id of the story that is getting updated
      #
      # @return [Hashie::Mash] story updated response
      #
      # @example 
      #   Pivit::Client.update_story(12345, 11111, { :name => "awesome new story name"})
      #
      # @author Jason Truluck
      def update_story(project_id, story_id, options = {})
        options = { :story => options }
        put("projects/#{project_id}/stories/#{story_id}",  options).story
      end
    
      # Delete a story
      # 
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#delete_story
      #
      # @param [Integer] project_id the id of the project that contains the
      # story
      # @param [Integer] story_id the id of the story that is getting deleted
      #
      # @return [Hashie::Mash] story deleted response
      #
      # @example 
      #   Pivit::Client.update_story(12345, 11111)
      ##
      # @author Jason Truluck
      def delete_story(project_id, story_id, options = {})
        delete("projects/#{project_id}/stories/#{story_id}", options).story
      end
     
      # Move a story before another story
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#move_story
      #
      # @param [Integer] project_id the id of the project that contains the
      # story
      # @param [Integer] story_id the id of the story that is getting moved
      # @param [Integer] story_target_id the id of the story that the other
      # story is moving before
      #
      # @return [Hashie::Mash] story move response
      #
      # @example 
      #   Pivit::Client.move_story_before(12345, 11111, 22222)
      ##
      # @author Jason Truluck
      def move_story_before(project_id, story_id, story_target_id, options = {})
        move_story(project_id, story_id, story_target_id, :before, options)
      end
      
      # Move a story after another story
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#move_story
      #
      # @param [Integer] project_id the id of the project that contains the
      # story
      # @param [Integer] story_id the id of the story that is getting moved
      # @param [Integer] story_target_id the id of the story that the other
      # story is moving after
      #
      # @return [Hashie::Mash] story move response
      #
      # @example 
      #   Pivit::Client.move_story_after(12345, 11111, 22222)
      ##
      # @author Jason Truluck
      def move_story_after(project_id, story_id, story_target_id, options = {})
        move_story(project_id, story_id, story_target_id, :after, options)
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
        options.merge!(:payload => file)
        post("projects/#{project_id}/stories/#{story_id}/attachments", options).attachment
      end


      private
      def move_story(project_id, story_id, story_target_id, direction, options = {})
        options.merge!("move\[move\]" => direction, "move\[target\]" =>  story_target_id)
        post("projects/#{project_id}/stories/#{story_id}/moves", options).story
      end
    end
  end
end
