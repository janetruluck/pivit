module Pivit
  class Client
    # Iteration management
    # 
    # @see https://www.pivotaltracker.com/help/api?version=v3#get_iterations
    module Iteration
      # Retrieve all iterations from the project
      #
      # @see https://www.pivotaltracker.com/help/api?version=v3#get_iterations
      #
      # @param project_id the id of the project
      #
      # @return [Hashie::Mash] iterations response
      #
      # @example 
      #   Pivit::Client.iterations(1111111)
      # 
      # @author Jason Truluck
      def iterations(project_id, options = {})
        get("projects/#{project_id}/iterations", options).iterations
      end

      # Retrieve all done iterations from the project
      #
      # @see https://www.pivotaltracker.com/help/api?version=v3#get_iterations
      #
      # @param project_id the id of the project
      #
      # @return [Hashie::Mash] iterations response
      #
      # @example 
      #   Pivit::Client.done_iterations(1111111)
      # 
      # @author Jason Truluck
      def done_iterations(project_id, options = {})
        get("projects/#{project_id}/iterations/done", options).iterations
      end

      # Retrieve all backlog iterations group from the project
      #
      # @see https://www.pivotaltracker.com/help/api?version=v3#get_iterations
      #
      # @param project_id the id of the project
      #
      # @return [Hashie::Mash] iterations response
      #
      # @example 
      #   Pivit::Client.iteration_backlog(1111111)
      # 
      # @author Jason Truluck
      def iteration_backlog(project_id, options = {})
        get("projects/#{project_id}/iterations/backlog", options).iterations
      end

      # Retrieve all current iterations group from the project
      #
      # @see https://www.pivotaltracker.com/help/api?version=v3#get_iterations
      #
      # @param project_id the id of the project
      #
      # @return [Hashie::Mash] iterations response
      #
      # @example 
      #   Pivit::Client.iteration_current(1111111)
      # 
      # @author Jason Truluck
      def iteration_current(project_id, options = {})
        get("projects/#{project_id}/iterations/current", options).iterations
      end
      
      # Retrieve all current and backlog iterations from the project
      #
      # @see https://www.pivotaltracker.com/help/api?version=v3#get_iterations
      #
      # @param project_id the id of the project
      #
      # @return [Hashie::Mash] iterations response
      #
      # @example 
      #   Pivit::Client.iteration_current_and_backlog(1111111)
      # 
      # @author Jason Truluck
      def iteration_current_and_backlog(project_id, options = {})
        get("projects/#{project_id}/iterations/current_backlog", options).iterations
      end
    end
  end
end
