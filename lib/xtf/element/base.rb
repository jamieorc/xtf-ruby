class XTF::Element::Base
  BASE_ATTRIBUTE_KEYS = [:field, :max_snippets, :boost]

  def self.attribute_keys(*args)
    array = args.flatten
    list = array.inspect
    class_eval(%Q{def attribute_keys() #{list} end}, __FILE__, __LINE__)
    array.each do |k|
      attr_accessor k
    end
  end

  attribute_keys *BASE_ATTRIBUTE_KEYS
  
  attr_reader   :tag_name
  
  # Takes a +Hash+ of attributes and sets them. Silently ignores erroneous keys.
  def initialize(*args)
    params = args[0]
    attribute_keys.each { |k| self.__send__("#{k}=", params[k]) if params.key?(k) } if params
  end
    
  # Returns a +Hash+ of the attributes listed in +ATTRIBUTE_KEYS+ with their values.
  # The keys are +Symbol+s.
  def attributes
    self.attribute_keys.inject({}) do |hash, key|
      hash[key] = self.__send__(key) if self.__send__(key)
      hash
    end
  end
  
end