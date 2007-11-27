class XTF::Element::Term < XTF::Element::Base
  attr_accessor :value
  def initialize(*args)
    super
    @value = nil
    @value = @attributes.delete(:value)
  end
  
  def to_xml_node
    xml = XTF::XML::Element.new 'term'
    self.attributes.each_pair { |key, value| xml.attributes[key.to_s.camelize(:lower)] = value if value}
    xml.text = self.value
    xml
  end
  def to_xml
    to_xml_node.to_s
  end
end