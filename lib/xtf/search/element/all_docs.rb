# This class is used inside a +Query+ to retrieve all docs. It's primary purpose is
# for use with +Facet+s:
#
#   query = Query.new
#   query.content << AllDocs.new
#   query.content << Facet.new('word')
#
class XTF::Search::Element::AllDocs

  attr_reader :tag_name

  def initialize
    @tag_name = "all_docs"
    super
  end

  def to_xml_node
    XTF::XML::Element.new(self.tag_name.to_s.camelize(:lower))
  end
  def to_xml
    to_xml_node.to_s
  end
end
