require 'modules/simple_find'

class Skoledistrikt < ActiveOIO::Base
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


  def skoler
    distriktnr = self.ref.split('/').last
    Skole.find(:all,:from => "/danmark/kommuner/#{kommune.nr}/skoledistrikter/#{distriktnr}/skoler")
    
  end
end