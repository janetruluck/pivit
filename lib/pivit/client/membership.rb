# Membership

module Pivit
  class Client
    # Membership management
    # 
    # @see https://www.pivotaltracker.com/help/api?version=v3#get_memberships
    module Membership
      # Retrieve a single membership from your account
      #
      # @see https://www.pivotaltracker.com/help/api?version=v3#get_membership_info
      #
      # @param [Integer] project_id the id of the project that you want to retrieve memberships from
      # @param [Integer] membership_id the id of the membership that you want to retrieve
      #
      # @return [Hashie::Mash] membership response
      #
      # @example 
      #   Pivit::Client.membership(1111111, 123456)
      #
      # @author Jason Truluck
      def membership(project_id, membership_id, options = {})
        get("projects/#{project_id}/memberships/#{membership_id}", options).memberships.first
      end

      # Retrieve all memberships from your account
      #
      # @see https://www.pivotaltracker.com/help/api?version=v3#get_memberships
      #
      # @param [Integer] project_id the id of the project that contains the memberships
      #
      # @return [Hashie::Mash] memberships response
      #
      # @example 
      #   Pivit::Client.memberships(1111111)
      # 
      # @author Jason Truluck
      def memberships(project_id, options = {})
        get("projects/#{project_id}/memberships", options).memberships
      end

      # Create a membership
      # 
      # Provide the parameters you want to use for the membership via the options hash.
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#add_membership
      #
      # @param [Integer] project_id the id of the project that contains the membership
      # @param [String] email the email address of the member that is being added
      # @param [String] role the role of the member that is being added
      #
      # @return [Hashie::Mash] membership created response
      #
      # @example 
      #   Pivit::Client.create_membership(12345, "test@example.com", "Member")
      #
      # @author Jason Truluck
      def create_membership(project_id, email, role,  options = {})
        options.merge!({ :membership => { :role => role, :person => { :email => email }}})
        post("projects/#{project_id}/memberships", options).membership
      end
      
      # Delete a membership
      #
      # @see https://www.pivotaltracker.com/help/api?version=v3#remove_membership
      #
      # @param [Integer] project_id the id of the project that contains the membership
      # @param [Integer] membership_id the id of the membership that is getting deleted
      #
      # @return [Hashie::Mash] membership deleted response
      #
      # @example 
      #   Pivit::Client.update_membership(12345, 11111)
      ##
      # @author Jason Truluck
      def delete_membership(project_id, membership_id, options = {})
        delete("projects/#{project_id}/memberships/#{membership_id}", options).membership
      end
    end
  end
end
