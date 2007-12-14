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

class XTF::Element::ResultData
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