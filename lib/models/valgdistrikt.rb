require 'modules/simple_find'

class Valgdistrikt < ActiveOIO::Base
  include SimpleFind
  def kommune
    k = self.attributes['kommune']
    if(k.respond_to?('navn'))
      k
    else
      newKommune = Kommune.find(k.ref.split('/').last)
      self.attributes['kommune'] = newKommune
      newKommune
    end
  end
end