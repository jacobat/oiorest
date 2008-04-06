require 'modules/simple_find'

class Kommune < ActiveOIO::Base
  include SimpleFind


  def skoler
    if(self.attributes['skoler'] == nil)
      sk = Skole.find(:all,:from  => "/danmark/kommuner/#{nr}/skoler")
      sk.each do |s|
        s.attributes['kommune'] = self
      end
      self.attributes['skoler'] = sk
    end
    self.attributes['skoler']
  end

  def lokaliteter
    if(self.attributes['lokaliteter'] == nil)
      loks = Lokalitet.find(:all,:from => "/danmark/kommuner/#{nr}/lokaliteter")
      loks.each do |l|
        l.attributes['kommune'] = self
      end
      self.attributes['lokaliteter'] = loks
    end
    self.attributes['lokaliteter']
  end

  def skoledistrikter
    if(self.attributes['skoledistrikter'] == nil)
      distr = Skoledistrikt.find(:all,:from => "/danmark/kommuner/#{nr}/skoledistrikter")
      distr.each do |d|
        d.attributes['kommune'] = self
      end
      self.attributes['skoledistrikter'] = distr
    end
    self.attributes['skoledistrikter']
  end
end
