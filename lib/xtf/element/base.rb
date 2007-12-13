class XTF::Element::Base
  ATTRIBUTE_KEYS = [:field, :max_snippets, :boost]
  
  ATTRIBUTE_KEYS.each { |k| attr_accessor k }
  attr_reader   :tag_name
  
  # Takes a +Hash+ of attributes and sets them. Silently ignores erroneous keys.
  def initialize(*args)
    params = args[0] || {}
    ATTRIBUTE_KEYS.each { |k| self.__send__("#{k}=", params[k]) }
  end
  
  def attribute_keys
    ATTRIBUTE_KEYS
  end
  
  # Returns a +Hash+ of the attributes listed in +ATTRIBUTE_KEYS+ with their values.
  # The keys are +Symbol+s.
  def attributes
    self.attribute_keys.inject({}) { |hash, key| hash[key] = self.__send__(key); hash }
  end

end