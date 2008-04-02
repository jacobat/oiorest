require 'rubygems'
require 'activeresource'

class ActiveOIO < ActiveResource::Base
  self.site = 'http://oiorest.dk/danmark/'

  ## enable logger to see request/response in STDOUT
  #self.logger = Logger.new(STDOUT)

  class << self

    ## remove .xml from the url
    def element_path(id, prefix_options = {}, query_options = nil)
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      "#{prefix(prefix_options)}#{collection_name}/#{id}#{query_string(query_options)}"
    end

    ## Remove .xml from the url.
    def collection_path(prefix_options = {}, query_options = nil)
      prefix_options, query_options = split_options(prefix_options) if query_options.nil?
      "#{prefix(prefix_options)}#{collection_name}#{query_string(query_options)}"
    end

    ## this method override makes it possible to retrieve arrays of results
    def instantiate_collection(collection, prefix_options = {})
      ## collection with timestamps
      if collection.size == 3
        value = collection.values[1]
      ## collection without timestamp
      elsif collection.size ==2
        value = collection.values[0]
      end
      if(value.is_a? Array)
      # Assume the value contains an array of elements to create
      return value.collect!  { |record| instantiate_record(record, prefix_options) }
    elsif(value.is_a? Hash) # search results 
      result = []
      result << instantiate_record(value, prefix_options)
    end
    end
  end
end

## Inflections for OIO
Inflector.inflections do |inflect|
  inflect.irregular 'kommune', 'kommuner'
  inflect.irregular 'lokalitet', 'lokaliteter'
  inflect.irregular 'postdistrikt', 'postdistrikter'
  inflect.irregular 'region', 'regioner'
  inflect.irregular 'skole', 'skoler'
  inflect.irregular 'skoledistrikt', 'skoledistrikter'
  inflect.irregular 'sogn', 'sogne'
  inflect.irregular 'valgdistrikt', 'valgdistrikter'
end
 