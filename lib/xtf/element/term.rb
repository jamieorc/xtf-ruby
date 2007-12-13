# Models a single XTF Term. However, if the term is surrounded by double-quotes, then
# a Phrase will be emitted for to_xml_node().

class XTF::Element::Term < XTF::Element::Base
  attr_accessor :value
  attr_accessor :section_type 

  # +new+ accepts an optional first argument for +value+ as well as an optional 
  # first or second argument +Hash+ of the +Term+'s +attributes+.
  # +value+ may be passed as the first argument or in attributes +Hash+ with key +:value+.
  # +section_type+ may be passed in the attributes +Hash+ with key +:section_type+.
  def initialize(*args)
    @tag_name = "term"
    @value = args.shift if args[0].kind_of?(String)
    params = args[0] || {}
    @value = params.delete(:value) unless @value
    @section_type = params.delete(:section_type)
    super
    @value.strip! unless @value.nil?
  end
  
  # For convenience, if the Term's value is double-quoted, it will be parsed as a Phrase. 
  # "this phrase" woud yield:
  # 
  #  <phrase>
  #     <term>this</term
  #     <term>phrase</term
  #   </phrase>
  # 
  def to_xml_node
    if self.value =~ /^".*"$/
      terms = self.value.slice(1..-2).split(" ")
      puts terms.inspect
      phrase = XTF::Element::Clause.new("phrase", self.attributes)
      terms.each { |t| phrase.content << XTF::Element::Term.new(t) }
      phrase.to_xml_node
    else
      xml = XTF::XML::Element.new(self.tag_name)
      self.attributes.each_pair { |key, value| xml.attributes[key.to_s.camelize(:lower)] = value if value}
      xml.text = self.value
      xml
    end
  end
  def to_xml
    to_xml_node.to_s
  end
end