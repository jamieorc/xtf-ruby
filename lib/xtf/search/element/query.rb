class XTF::Search::Element::Query < XTF::Search::Element::Base

  STYLE_DEFAULT = "style/crossQuery/resultFormatter/default/resultFormatter.xsl"
  INDEX_PATH_DEFAULT = "index"

  attribute_keys :index_path, :style, :sort_docs_by, :start_doc, :max_docs, :term_limit, :work_limit,
                 :max_context, :max_snippets, :term_mode, :field, :normalize_scores, :explain_scores

  attr_accessor :content # one Term or Clause, spellcheck, and any number of facet tags all in an array

  def initialize(*args)
    @tag_name = 'query'
    params = args[0] || {}
    self.content = params.delete(:content) || []
    super(params)

    @style ||= STYLE_DEFAULT
    @index_path ||= INDEX_PATH_DEFAULT
  end

  # Accepts a +Term+ or a +String+ which is converted to a +Term+ and adds it to the +content+.
  def term=(value)
    self.content << (value.is_a?(XTF::Search::Element::Term) ? value : XTF::Search::Element::Term.new(value))
  end

  def content=(value)
    value = [value] unless value.is_a?(Array)
    @content = value
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
