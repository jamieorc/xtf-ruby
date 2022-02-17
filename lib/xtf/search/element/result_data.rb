class XTF::Search::Element::ResultData
  attr_accessor :value
  attr_reader :tag_name

  def initialize(data=nil)
    @tag_name = "resultData"
    @value = data
  end

  def to_xml_node
    xml = XTF::XML::Element.new(self.tag_name)
    xml.text = self.value
    xml
  end
  def to_xml
    to_xml_node.to_s
  end
end
