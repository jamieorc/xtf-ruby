class XTF::Element::Base
  ATTRIBUTE_KEYS = [:field, :max_snippets, :boost]
  
  ATTRIBUTE_KEYS.each { |k| attr_accessor k }
  attr_reader   :tag_name
  
  def initialize(*args)
    params = args[0] || {}
    params.each_pair { |k, v| self.__send__("#{k}=", v) }
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