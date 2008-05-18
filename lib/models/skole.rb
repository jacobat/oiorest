require 'modules/simple_find'

class Skole < ActiveOIO::Base
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
  
  
  def skoledistrikt
    sd = self.attributes['skoledistrikt']
    if(sd.respond_to?('navn'))
      sd
    else
      distriktId = sd.ref.split('/').last
      kommuneNr = self.kommune.nr
      newSd = Skoledistrikt.find(:first,:from => "/danmark/kommuner/#{kommuneNr}/skoledistrikter/#{distriktId}")
      newSd.attributes['ref'] = "/danmark/kommuner/#{kommuneNr}/skoledistrikter/#{distriktId}"
      self.attributes['skoledistrikt'] = newSd
      newSd
    end
  end
  
  def to_param
    self.attributes['institutionsnr']
  end
  
end