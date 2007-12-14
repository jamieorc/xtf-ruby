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

# Extends +Near+, as they are identical except for +tag_name+
class XTF::Element::OrNear < XTF::Element::Near
  attribute_keys BASE_ATTRIBUTE_KEYS, :slop
  
  # +slop+ is required. You can pass it in as the first argument or in the attributes +Hash+
  # with the key +:slop+. 
  def initialize(*args)
    @tag_name = "orNear"
    super
  end
end