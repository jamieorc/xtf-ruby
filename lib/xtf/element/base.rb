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

class XTF::Element::Base
  BASE_ATTRIBUTE_KEYS = [:field, :max_snippets, :boost]

  def self.attribute_keys(*args)
    array = args.flatten
    list = array.inspect
    class_eval(%Q{def attribute_keys() #{list} end}, __FILE__, __LINE__)
    array.each do |k|
      attr_accessor k
    end
  end

  attribute_keys *BASE_ATTRIBUTE_KEYS
  
  attr_reader   :tag_name
  
  # Takes a +Hash+ of attributes and sets them. Silently ignores erroneous keys.
  def initialize(*args)
    params = args[0]
    attribute_keys.each { |k| self.__send__("#{k}=", params[k]) if params.key?(k) } if params
  end
    
  # Returns a +Hash+ of the attributes listed in +ATTRIBUTE_KEYS+ with their values.
  # The keys are +Symbol+s.
  def attributes
    self.attribute_keys.inject({}) do |hash, key|
      hash[key] = self.__send__(key) if self.__send__(key)
      hash
    end
  end
  
end