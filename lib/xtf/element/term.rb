# Copyright 2007 James (Jamie) Orchard-Hays
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
  
  # For convenience, if the Term's value matches /[\-\s\\\/.,;:]+/, it will be parsed as a Phrase. 
  # Double quotes on either end will be removed.
  # 
  # "this phrase" woud yield:
  # 
  #  <phrase>
  #     <term>this</term
  #     <term>phrase</term
  #   </phrase>
  # 
  def to_xml_node
    delimeters = /[\-\s\\\/.,;:]+/
    if self.value =~ delimeters
      terms = self.value.split(delimeters)
      terms.first.gsub!(/^"/, "")
      terms.shift if terms.first == ""
      terms.last.gsub!(/"$/,"")
      terms.pop if terms.last == ""
      phrase = XTF::Element::Phrase.new(self.attributes)
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