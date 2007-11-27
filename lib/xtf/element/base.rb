class XTF::Element::Base
  
  def self.attribute_keys
    [:field, :max_snippets, :boost]
  end
  
  attr_accessor :attributes
  attr_accessor :section_type #available on all elements except <not>
  
  
  def initialize(*args)
    @attributes = self.class.attribute_keys.inject({}) { |hash, key| hash[:key] = nil; hash }
    params = args[0] || {}
    params = params.symbolize_keys
    params.assert_valid_keys(self.class.attribute_keys)
    @attributes.merge!(params)
  end

end