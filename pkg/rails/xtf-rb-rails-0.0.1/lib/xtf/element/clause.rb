class XTF::Element::Clause < XTF::Element::Base
  VALID_TAG_NAMES = %w{phrase exact and or or_near orNear not near range}
  
  # an Array that contains any number of clauses and/or terms
  attr_accessor :content
  attr_accessor :section_type #available on all elements except <not> and <facet>
  
  def initialize(*args)
    @tag_name = args.shift.to_s if args[0].is_a?(String) or args[0].is_a?(Symbol)
    super
    tn = @attributes.delete(:tag_name)
    @tag_name ||= tn
    raise ArgumentError, "need tag_name for XTF::Element::Clause" unless @tag_name
    raise ArgumentError, "tag_name #{@tag_name} not valid for XTF::Element::Clause. Must be one of: #{VALID_TAG_NAMES.join(', ')}" unless VALID_TAG_NAMES.include?(@tag_name)
    
    @content = @attributes.delete(:content) || []
    @content = [@content] unless @content.is_a?(Array)
  end
  
  def content=(value)
    value = [value] unless value.is_a?(Array)
    @content = value
  end
  
  def to_xml_node
    xml = XTF::XML::Element.new self.tag_name.camelize(:lower)
    self.attributes.each_pair { |key, value| xml.attributes[key.to_s.camelize(:lower)] = value if value}
    self.content.each {|node| xml.add_element(node.to_xml_node)}
    xml
  end
  def to_xml
    to_xml_node.to_s
  end  
end