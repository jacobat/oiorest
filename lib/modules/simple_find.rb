module SimpleFind
  module ClassMethods
    def find_by_name(name)
      self.find(:all, :params =>{:q => name})
    end
    
    def find(*arguments)
      scope   = arguments.slice!(0)
      options = arguments.slice!(0) || {}

      case scope
        when :all   then find_every(options)
        when :first then find(find_every(options).first.nr)
        when :one   then find_one(options)
        else             find_single(scope, options)
      end
    end
   
  end

  def self.included(receiver)
    receiver.extend ClassMethods
  end
end
