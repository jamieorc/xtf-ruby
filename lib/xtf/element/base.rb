class XTF::Element::Base
  def self.attributes
    [:field, :max_snippets, :boost]
  end
  attr_accessor *self.attributes
  attr_accessor :section_type #available on all elements except <not>
  
  
  def initialize(*args)
    attributes = args[0] || {}
    validate_params(attributes)
    attributes.each_pair { |key, value| self.__send__("#{key.to_sym}=", value) }
  end
  
  def attributes_hash
    self.class.attributes.inject({}) { |hash, key| hash[key] = self.__send__(key); hash }
  end
  
  protected
  def validate_params(params)
    raise "Invalid parameters during initialization: #{(params.symbolize_keys.keys - self.class.attributes).join(',')}" unless (params.symbolize_keys.keys - self.class.attributes).empty?
  end
  
  #TODO decide whether to use this or active support's hash extensions
  def symbolize_keys(hash)
    hash.inject({}) do |options, (key, value)|
      options[key.to_sym] = value
      options
    end
  end
end