require 'modules/simple_find'

class Postdistrikt < ActiveOIO::Base
  include SimpleFind
  
  def to_param
    self.attributes['nr']
  end
end