class XTF::Element::Query < XTF::Element::Base

  STYLE_DEFAULT = "style/crossQuery/resultFormatter/default/resultFormatter.xsl"
  INDEX_PATH_DEFAULT = "index"

  attr_accessor :content # one Term or Clause, spellcheck, and any number of facet tags all in an array

  def initialize(*args)
    @tag_name = 'query'
    super
    @attributes[:style] ||= STYLE_DEFAULT
    @attributes[:index_path] ||= INDEX_PATH_DEFAULT
    
    @content = @attributes.delete(:content) || []
    @content = [@content] unless @content.is_a?(Array)
  end

  def to_xml_node
    xml = XTF::XML::Element.new(self.tag_name)
    self.attributes.each_pair { |key, value| xml.attributes[key.to_s.camelize(:lower)] = value if value}
    # TODO validate only one term or clause present?
    self.content.each {|node| xml.add_element(node.to_xml_node)}
    xml
  end
  def to_xml
    to_xml_node.to_s
  end  
  
end