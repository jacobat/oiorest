require 'rubygems'
require 'activeresource'

class ActiveOIO < ActiveResource::Base
  self.site = 'http://oiorest.dk/danmark/'
  
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
      if collection.is_a? Array
        collection.collect! { |record| instantiate_record(record, prefix_options) }
      elsif collection.is_a? Hash
        # debugger
        if collection.size == 3
          value = collection.values[1]
          if value.is_a? Array
            # Assume the value contains an array of elements to create
            return value.collect!  { |record| instantiate_record(record, prefix_options) }
          elsif value.is_a? Hash
            # Assume the value contains a single row result
            result = []
            result << instantiate_record(value, prefix_options)
          else
            raise ArgumentError("Expected a nested Array or Hash but got #{value.inspect}")
          end
        else
          # Assume the result was a single row, so encapsulate it in an array
          result = []
          result << instantiate_record(collection, prefix_options)
          return result
        end
      elsif
        raise ArgumentError, "Expected an Array or Hash, but got #{collection.inspect}"
      end
    end

  end
end

## Inflections for OIO
Inflector.inflections do |inflect|
 inflect.irregular 'postdistrikt', 'postdistrikter'
 inflect.irregular 'sogn', 'sogne'
 inflect.irregular 'kommune', 'kommuner'
 inflect.irregular 'region', 'regioner'
end