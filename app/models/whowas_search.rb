class WhowasSearch
  # calling Whowas in your main application is simple
  # returns a hash with the results and any errors encountered
  def self.search(input)
    Whowas.search(input)
  end
end