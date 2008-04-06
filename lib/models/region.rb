require 'modules/simple_find'

class Region < ActiveOIO::Base
  include SimpleFind
  
  def kommuner
      if(self.attributes['kommuner'] == nil)
        sk = Kommune.find(:all,:from  => "/danmark/regioner/#{nr}/kommuner")
        self.attributes['kommuner'] = sk
      end
      self.attributes['kommuner']
  end
end
