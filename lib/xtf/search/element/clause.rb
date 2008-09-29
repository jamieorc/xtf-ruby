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

class XTF::Search::Element::Clause < XTF::Search::Element::Base
  VALID_TAG_NAMES = %w{phrase exact and or or_near orNear not near range}
  
  # an Array that contains any number of clauses and/or terms
  attr_accessor :content
  
  # convenience to create a +Term+ from a +String+ and insert it into +content+
  attr_accessor :term
  
  attr_accessor :section_type #available on all elements except <not> and <facet>
  
  # This is a factory method for creating subclasses directly from +Clause+. 
  # The tag_name may be passed as the first argument or as the value to the key 
  # +:tag_name+ or +'tag_name'+
  def self.create(*args)
    tag_name = args.shift.to_s if args[0].is_a?(String) || args[0].is_a?(Symbol)
    params = (args[0] || {}).symbolize_keys
    tag_name = params.delete(:tag_name) unless tag_name
    
    raise ArgumentError, "need tag_name for XTF::Search::Element::Clause" unless tag_name
    raise ArgumentError, "tag_name #{tag_name} not valid for XTF::Search::Element::Clause. Must be one of: #{VALID_TAG_NAMES.join(', ')}" unless VALID_TAG_NAMES.include?(tag_name)
    
    klass = eval("XTF::Search::Element::#{tag_name.to_s.camelize}") # scope the name to avoid conflicts, especially with Range
    klass.new(params)
  end
  
  def initialize(*args)
    params = args[0] || {}
    self.content = params.delete(:content) || []
    self.term = params.delete(:term) if params.has_key?(:term)
    super(params)
    
    raise ArgumentError, "need tag_name for XTF::Search::Element::Clause (maybe you should call Clause.create(:tag_name) ? )" unless @tag_name
    raise ArgumentError, "tag_name #{@tag_name} not valid for XTF::Search::Element::Clause. Must be one of: #{VALID_TAG_NAMES.join(', ')}" unless VALID_TAG_NAMES.include?(@tag_name)
  end
  
  # Accepts a +Term+ or a +String+ which is converted to a +Term+ and adds it to the +content+.
  def term=(value)
    self.content << (value.is_a?(XTF::Search::Element::Term) ? value : XTF::Search::Element::Term.new(value))
  end
  
  def content=(value)
    value = [value] unless value.is_a?(Array)
    @content = value
  end
  
  # TODO add section_type
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