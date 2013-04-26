module Pivit
  class Client
    # Project management
    # 
    # @see http://www.pivotaltracker.com/help/api?version=v3#getting_projects
    module Project
      # Retrieve a single project from your account
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#getting_projects
      #
      # @param [Integer] project_id the id of the project that you want to
      # retrieve
      #
      # @return [Hashie::Mash] project response
      #
      # @example 
      #   Pivit::Client.project(123456)
      #
      # @author Jason Truluck
      def project(project_id, options = {})
        get("projects/#{project_id}", options).project
      end

      # Retrieve all projects from your account
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#getting_projects
      #
      # @return [Hashie::Mash] projects response
      #
      # @example 
      #   Pivit::Client.project      
      # 
      # @author Jason Truluck
      def projects(options = {})
        get("projects", options).projects
      end

      # Create a Project
      # 
      # Provide the parameters you wantt to use for the project via the options
      # hash 
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#add_project
      #
      # @return [Hashie::Mash] project created response
      #
      # @example 
      #   Pivit::Client.add_project({:name => "Test Project", :iteration_length
      #   => "2"})
      # 
      # @author Jason Truluck
      def add_project(options = {})    
        options.merge!(:with_query_params => true) if options[:with_query_params].nil?
        response = post("projects", options).env
        if response[:body].project.nil?
          response[:body].message
        else
          response[:body].project
        end
      end
    end
  end
end
