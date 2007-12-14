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

class XTF::Element::SectionType
  
  attr_accessor :content # one Term or Clause
  attr_reader :tag_name
  
  def initialize(content = nil)
    @tag_name = "sectionType"
    @content = content
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