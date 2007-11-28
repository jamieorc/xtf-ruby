class XTF::Element::Facet < XTF::Element::Base
  
  # can take a String or Symbol as first argument for required attribute #field
  def initialize(*args)
    @tag_name = "facet"
    field = args.shift.to_s if args[0].is_a?(String) or args[0].is_a?(Symbol)
    super
    @attributes[:field] = field if field
    (raise ArgumentError, "need field for XTF::Element::Facet") unless @attributes.has_key?(:field)
  end
  
  def to_xml_node
    xml = XTF::XML::Element.new(self.tag_name)
    self.attributes.each_pair { |key, value| xml.attributes[key.to_s.camelize(:lower)] = value if value}
    xml
  end
  def to_xml
    to_xml_node.to_s
  end
  
end