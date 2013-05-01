# Tasks

module Pivit
  class Client
    # Task management
    # 
    # @see http://www.pivotaltracker.com/help/api?version=v3#getting_stories
    module Task
      # Retrieve a single task from your account
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#getting_stories
      #
      # @param [Integer] project_id the id of the project that you want to
      # retrieve stories from
      # @param [Integer] story_id the id of the story that you want to
      # retrieve
      # @param [Integer] task_id the id of the task that you want to
      # retrieve
      #
      # @param [Integer] project_id the id of the project that contains the
      # task
      #
      # @return [Hashie::Mash] task response
      #
      # @example 
      #   Pivit::Client.task(1111111, 123456, 67890)
      #
      # @author Jason Truluck
      def task(project_id, story_id, task_id, options = {})
        get("projects/#{project_id}/stories/#{story_id}/tasks/#{task_id}", options).task
      end

      # Retrieve all tasks from a story
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#getting_tasks
      #
      # @param [Integer] project_id the id of the project that contains the stories
      # @param [Integer] stroy_id the id of the story that contains the tasks
      #
      # @return [Hashie::Mash] tasks response
      #
      # @example 
      #   Pivit::Client.tasks(1111111, 123456)
      # 
      # @author Jason Truluck
      def tasks(project_id, story_id, options = {})
        get("projects/#{project_id}/stories/#{story_id}/tasks", options).tasks
      end

      # Create a task
      # 
      # Provide the parameters you want to use for the task via the options
      # hash 
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#add_task
      #
      # @param [Integer] project_id the id of the project that contains the task
      # @param [Integer] story_id the id of the story that contains the task
      #
      # @return [Hashie::Mash] task created response
      #
      # @example 
      #   Pivit::Client.create_task_type=> "feature", :name => "Task"})
      #
      # @author Jason Truluck
      def create_task(project_id, story_id, options = {})
        options = { :task => options }
        post("projects/#{project_id}/stories/#{story_id}/tasks", options).task
      end

      # Update a task
      # 
      # Provide the parameters you want to use for the task via the options
      # hash 
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#update_task
      #
      # @param [Integer] project_id the id of the project that contains the task
      # @param [Integer] story_id the id of the story that contains the task
      # @param [Integer] task_id the id of the task that is getting updated
      #
      # @return [Hashie::Mash] task updated response
      #
      # @example 
      #   Pivit::Client.update_task(12345, 11111, 67890, { :name => "awesome new task name"})
      #
      # @author Jason Truluck
      def update_task(project_id, story_id, task_id, options = {})
        options = { :task => options }
        put("projects/#{project_id}/stories/#{story_id}/tasks/#{task_id}",  options).task
      end
    
      # Delete a task
      # 
      # @see http://www.pivotaltracker.com/help/api?version=v3#delete_task
      #
      # @param [Integer] project_id the id of the project that contains the task
      # @param [Integer] story_id the id of the story that contains the task
      # @param [Integer] task_id the id of the task that is getting deleted
      #
      # @return [Hashie::Mash] task deleted response
      #
      # @example 
      #   Pivit::Client.update_task(12345, 11111, 67890)
      #
      # @author Jason Truluck
      def delete_task(project_id, story_id, task_id, options = {})
        delete("projects/#{project_id}/stories/#{story_id}/tasks/#{task_id}", options).task
      end
    end
  end
end
