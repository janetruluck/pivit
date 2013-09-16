# lib/client/project.rb
module Pivit
  class Client
    # Project management
    #
    # @see http://www.pivotaltracker.com/help/api?version=v3#getting_projects
    module Project
      # Retrieve a single project from your account
      #
      # @see https://www.pivotaltracker.com/help/api?version=v3#get_project_all_projects
      #
      # @param [Integer] project_id the id of the project that you want to retrieve
      #
      # @return [Hashie::Mash] project response
      #
      # @example 
      #   Pivit::Client.project(123456)
      #
      # @author Jason Truluck
      def project(project_id, options = {})
        get("projects/#{project_id}", options)
      end
      # Retrieve all projects from your account
      #
      # @see https://www.pivotaltracker.com/help/api/rest/v5#Projects
      #
      # @return [Array] projects response
      #
      # @example
      #   Pivit::Client.projects
      #
      # @author Jason Truluck
      def projects(options = {})
        get("projects", options)
      end
      # Create a Project
      #
      # Provide the parameters you wantt to use for the project via the options hash
      #
      # @see https://www.pivotaltracker.com/help/api/rest/v5#projects_post
      # 
      # @return [Hashie::Mash] project created response
      #
      # @example
      #   Pivit::Client.create_project({:name => "Test Project", :iteration_length => "2"})
      #
      # @author Jason Truluck
      def create_project(options = {})
        options = { :project => options }
        post("projects", options)
      end
    end
  end
end
