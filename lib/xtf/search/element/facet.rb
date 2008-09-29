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

class XTF::Search::Element::Facet < XTF::Search::Element::Base
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