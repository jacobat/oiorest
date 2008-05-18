module SimpleFind
  module ClassMethods
    def find_by_name(name)
      self.find(:all, :params =>{:q => name})
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
  end
end
