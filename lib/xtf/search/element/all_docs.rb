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


# This class is used inside a +Query+ to retrieve all docs. It's primary purpose is
# for use with +Facet+s:
# 
#   query = Query.new
#   query.content << AllDocs.new
#   query.content << Facet.new('word')
# 
class XTF::Element::AllDocs
  
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