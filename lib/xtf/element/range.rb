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

class XTF::Element::Range < XTF::Element::Clause

  attribute_keys BASE_ATTRIBUTE_KEYS, :inclusive, :numeric

  attr_accessor :lower, :upper
  
  # +lower+ and +upper+ may be passed as the first and second arguments. 
  # If one is present, then both must be. Otherwise, they may be passed as
  # part of the attributes +Hash+ with the keys +:lower+ and +:upper+. 
  # An +ArgumentError+ will be raised if they are not provided.
  def initialize(*args)
    @tag_name = "range"

    # retrieve lower and upper if passed as first two arguments
    @lower = args.shift.to_s if args[0].is_a?(String) || args[0].is_a?(Integer)
    @upper = args.shift.to_s if args[0].is_a?(String) || args[0].is_a?(Integer)
    raise ArgumentError, "If you provide --lower-- as first argument, you must provide --upper-- as second." if @lower && !@upper

    params = args[0] || {}
    raise ArgumentError, "You have provided --lower-- and --upper-- as both arguments and attributes! Pass them as one or the other, but not both." if @lower && (params[:lower] || params[:upper])
    
    @lower = params[:lower] && params[:lower].to_s unless @lower
    @upper = params[:upper] && params[:upper].to_s unless @upper
    
    raise ArgumentError, "You must provide --lower-- and --upper-- as the first two arguments to new() or as members of the attributes Hash." unless @lower && @upper
    
    super
  end
  
  # TODO add section_type
  def to_xml_node
    xml = XTF::XML::Element.new self.tag_name.camelize(:lower)
    self.attributes.each_pair { |key, value| xml.attributes[key.to_s.camelize(:lower)] = value if value}
    lnode = XTF::XML::Element.new("lower")
    lnode.text = self.lower
    unode = XTF::XML::Element.new("upper")
    unode.text = self.upper
    xml.add_element(lnode)
    xml.add_element(unode)
    xml
  end
  
  
end
