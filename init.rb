# Include hook code here

# TODO: autorequire all models
require "models/adresse"
require "models/kommune"
require "models/lokalitet"
require "models/postdistrikt"
require "models/region"
require "models/skole"
require "models/skoledistrikt"
require "models/sogn"
require "models/valgdistrikt"

## Inflections for OIO
Inflector.inflections do |inflect|
  inflect.irregular 'kommune', 'kommuner'
  inflect.irregular 'lokalitet', 'lokaliteter'
  inflect.irregular 'postdistrikt', 'postdistrikter'
  inflect.irregular 'region', 'regioner'
  inflect.irregular 'skole', 'skoler'
  inflect.irregular 'skoledistrikt', 'skoledistrikter'
  inflect.irregular 'sogn', 'sogne'
  inflect.irregular 'valgdistrikt', 'valgdistrikter'
  inflect.irregular 'adresse', 'adresser'
end
