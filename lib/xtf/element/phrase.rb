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

class XTF::Element::Phrase < XTF::Element::Clause
  # Takes a +String+ and breaks it up into +Term+s:
  attr_accessor :phrase
  
  def initialize(*args)
    @tag_name = "phrase"
    params = args[0] || {}
    _phrase = params.delete(:phrase) 
    super(params)
    self.phrase = _phrase if _phrase
  end
  
  def phrase=(terms)
    raise ArgumentError unless terms.is_a?(String)
    terms = terms.split(PHRASE_DELIMITERS)
    terms.first.gsub!(/^"/, "")
    terms.shift if terms.first == ""
    terms.last.gsub!(/"$/,"")
    terms.pop if terms.last == ""
    terms.each { |t| self.content << XTF::Element::Term.new(t) }    
  end
  
end