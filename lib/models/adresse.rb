class Adresse < ActiveOIO::Base
  VALID_SEARCH_PARAMS = [:vejnavn, :husnr, :postnr, :vejnr, :kommunenr, :sognenr]
  
  def self.find(*arguments)    
    scope   = arguments.slice!(0)
    options = arguments.slice!(0) || {}
    if(options[:params])
      invalid_params = options[:params].keys.find_all{|k| !VALID_SEARCH_PARAMS.include? k.to_sym}    
      invalid_params.empty? or raise "INVALID SEARCH PARAM(s): #{ invalid_params.join(',') }. Must be one of these: #{VALID_SEARCH_PARAMS.join(', ')}"
    end

    case scope
      when :all   then find_every(options)
      when :first then find(find_every(options).first.to_param)
      when :one   then find_one(options)
      else             find_single(scope, options)
    end
  end
  
  def to_param
    self.ref.split('/').last
  end
end
