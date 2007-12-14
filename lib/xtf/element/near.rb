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

class XTF::Element::Near < XTF::Element::Clause
  attribute_keys BASE_ATTRIBUTE_KEYS, :slop
  
  # +slop+ is required. You can pass it in as the first argument or in the attributes +Hash+
  # with the key +:slop+. 
  def initialize(*args)
    @tag_name = "near"
    @slop = args.shift.to_s if args[0].is_a?(String) || args[0].is_a?(Integer)
    params = args[0] || {}
    raise ArgumentError, "supply slop as first argument or as attribute of Hash, but not both!" if @slop && params.key?(:slop)
    
    @slop = params.delete(:slop) unless @slop
    raise ArgumentError, "slop is required." unless @slop
    
    super
  end
end