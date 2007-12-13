class XTF::Element::Facet < XTF::Element::Base
  attribute_keys :field, :select, :sort_groups_by, :sort_docs_by, :include_empty_groups
    
  # can take a String or Symbol as first argument for required attribute #field
  def initialize(*args)
    @tag_name = "facet"
    @field = args.shift.to_s if args[0].is_a?(String) or args[0].is_a?(Symbol)
    params = args[0] || {}
    raise ArgumentError, "supply field as first argument or as attribute of Hash, but not both!" if @field && params.key?(:field)
    
    @field = params.delete(:field) unless @field
    raise ArgumentError, "field is required." unless @field
    
    super
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