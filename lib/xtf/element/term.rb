class XTF::Element::Term < XTF::Element::Base
  def self.attributes
    [:value, :section_type] | XTF::Element::Base.attributes
  end
  attr_accessor *self.attributes
    
end