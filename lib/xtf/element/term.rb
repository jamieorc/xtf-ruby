class XTF::Element::Term < XTF::Element::Base
  attr_accessor :value
  def initialize(*args)
    @value = args.shift if args[0].kind_of?(String)
    super
    val = @attributes.delete(:value)
    @value ||= val
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