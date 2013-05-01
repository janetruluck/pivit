module Pivit
  class Client
    # Activity management
    # 
    # @see http://www.pivotaltracker.com/help/api?version=v3#getting_activity
    module Activity
      # Retrieve all activity from your account
      #
      # Pass any of the specified query parameters via options 
      # Available from Pivotal Tracker:
      # limit - you can limit the number of activity feed items to a desired
      # number. Note the default value is 10, and there is a upper cap of 100
      # occurred_since_date - allows restricting the activity feed to only those
      # items that occurred after a supplied date (example format: 2009/12/18
      # 21:00:00 UTC)
      # newer_than_version - allows restricting the activity feed to only those
      # items that have a greater than supplied version
      #
      # @see http://www.pivotaltracker.com/help/api?version=v3#getting_activity
      #
      # @return [Hashie::Mash] activity response
      #
      # @example 
      #   Pivit::Client.activity
      #
      #   Pivit::Client.activity({:limit => 50})
      # 
      # @author Jason Truluck
      def activity(options = {})
        get("activities", options).activities
      end
    end
  end
end
