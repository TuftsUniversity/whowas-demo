require "middleware"

module Whowas
  def self.registered_mac
    # All you have to do is specify the search method classes in the order
    # they should be called.  The output for each search method should match
    # the input of the next.
    Middleware::Builder.new do
      use BluecatMac
    end
  end
end