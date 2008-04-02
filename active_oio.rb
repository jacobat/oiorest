require 'rubygems'
require 'activeresource'

class ActiveOIO < ActiveResource::Base
  self.site = 'http://oiorest.dk/danmark/'

  ## enable logger to see request/response in STDOUT
  #self.logger = Logger.new(STDOUT)

  class << self

    ## this method override makes it possible to retrieve arrays of results
    def instantiate_collection(collection, prefix_options = {})
      if collection.size == 3       # collection with timestamps
        value = collection.values[1]
      elsif collection.size == 2    # collection without timestamp
        value = collection.values[0]
      end
      # Assume the value contains an array of elements to create
      return value.collect!  { |record| instantiate_record(record, prefix_options) }
    end
  end
end

## Inflections for OIO
Inflector.inflections do |inflect|
  inflect.irregular 'postdistrikt', 'postdistrikter'
  inflect.irregular 'sogn', 'sogne'
  inflect.irregular 'kommune', 'kommuner'
  inflect.irregular 'region', 'regioner'
  inflect.irregular 'skole', 'skoler'
  inflect.irregular 'lokalitet', 'lokaliteter'

end
