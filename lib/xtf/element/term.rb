class XTF::Element::Term < XTF::Element::Base
  def self.attributes
    [:value, :section_type] | XTF::Element::Base.attribute_keys
  end
  attr_accessor *self.attributes
    
end