require 'modules/simple_find'

class Sogn < ActiveOIO::Base
  include SimpleFind

  def to_param
    self.attributes['nr']
  end
end
