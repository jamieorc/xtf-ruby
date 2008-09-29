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

class XTF::Element::And < XTF::Element::Clause
  attribute_keys BASE_ATTRIBUTE_KEYS, :fields, :use_proximity, :slop
  
  def initialize(*args)
    @tag_name = "and"
    params = args[0] || {}
    raise ArgumentError, "Provide :field or :fields, but not both" if params.key?(:field) && params.key?(:fields)
    raise ArgumentError, ":fields requires :slop" if params.key?(:fields) && !params.key?(:slop)
    raise ArgumentError, ":slop requires :fields" if params.key?(:slop) && !params.key?(:fields)
    super
  end
    
end