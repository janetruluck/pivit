module Pivit
  class Error < StandardError
    #Raised when there is an error with authentication 
    class AuthenticationError < Error; end
  end
end
