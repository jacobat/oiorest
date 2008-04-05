require 'modules/simple_find'

class Kommune < ActiveOIO::Base
  include SimpleFind

  def lokaliteter
    Lokalitet.find(:all,:from => "/danmark/kommuner/#{nr}/lokaliteter")
  end

  def skoledistrikter
    Skoledistrikt.find(:all,:from => "/danmark/kommuner/#{nr}/skoledistrikt")
  end  
end
