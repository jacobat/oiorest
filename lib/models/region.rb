require 'modules/simple_find'

class Region < ActiveOIO::Base
  include SimpleFind
  
  def kommuner
      if(self.attributes['kommuner'].class == Region::Kommuner)
        self.attributes['kommuner'] = Kommune.find(:all, :from  => "/"+ self.attributes['kommuner'].ref.split('/')[3..-1].join('/'))
      end
      self.attributes['kommuner']
  end

end
