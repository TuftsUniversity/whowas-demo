require "savon"

module Whowas
  class Bluecat
    # Whowas::Api provides the public interface to your API, accessed through the
    # "search" instance method.
    include Whowas::Api
    
    @@client = nil
    @@cookie = nil
    
    # Bluecat API configuration
    CONFIG = {
      id: ENV['BLUECAT_ID'],
      wsdl: ENV['BLUECAT_WSDL'], # absolute path in dotenv
      username: ENV['BLUECAT_USERNAME'],
      password: ENV['BLUECAT_PASSWORD']
    }
  
    # All custom API code is defined in the private methods below.  Naturally,
    # you can add private methods as needed for connecting to the API, etc. 
    private
    
    ## Required
    
    # Sends a search query with provided input to your API and returns results 
    # as a string.
    def search_api(input)
      client
      response = client.call :get_mac_address do
        message configurationId: CONFIG[:id], macAddress: input[:mac]
      end
      data = response.body[:get_mac_address_response][:return] rescue {}
      expand_properties data
    end
    
    def expand_properties(entity_ref)
      entity = entity_ref.dup
      properties = entity.delete(:properties).split(/\|(?=\w+=|$)/) rescue []
      properties.each do |property|
        key, value = property.strip.split("=", 2)
        entity[key.strip.to_sym] = (value.nil? || value.strip.blank?) ? nil : value.strip.gsub("\n", " ")
      end
      entity
    end
    
    def client
      if @@client.nil?
        @@client = Savon.client(wsdl: File.expand_path(CONFIG[:wsdl], __FILE__))

        response = @@client.call :login do 
          message username: CONFIG[:username], password: CONFIG[:password]
        end
        
        @@cookie = response.http.cookies
      end
      @@client
    end        
   
    ## Optional
    
    # Validates input to avoid unnecessary API calls.
    # MUST return true or raise a Whowas::Errors::InvalidInput error.
    # Replace "true" with your validation code.
    def validate(input)
      (input[:mac] && true) ||
      (raise Whowas::Errors::InvalidInput, "Invalid input for Bluecat API")
    end
    
    # Transforms input one last time before API call.
    # Will be called on input for all search_methods using this API.
    # For search_method-specific transformations, use the format_input method
    # in your search_method.
    def format(input)
      input
    end
  end
end