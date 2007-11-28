class XTF::Element::SectionType
  
  attr_accessor :content # one Term or Clause
  attr_reader :tag_name
  
  def initialize(content = nil)
    @content = content
    @tag_name = "sectionType"
  end
  
  def to_xml_node
    xml = XTF::XML::Element.new("sectionType")
    xml.add_element(self.content.to_xml_node) if self.content
    xml
  end
  def to_xml
    to_xml_node.to_s
  end  
end