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

# Code in this file is derived from Apache's Solr-Ruby project.

module XTF::XML
end

begin
  
  # If we can load rubygems and libxml-ruby...
  require 'rubygems'
  require 'xml/libxml'
  
  # then make a few modifications to XML::Node so it can stand in for REXML::Element
  class XML::Node
    # element.add_element(another_element) should work
    alias_method :add_element, :<<

    # element.attributes['blah'] should work
    def attributes
      self
    end
    
    def size
      self.properties.to_a.size
    end
    alias :length :size

    # element.text = "blah" should work
    def text=(x)
      self << x.to_s
    end
    
    def text
      self.content
    end
  end

  # Some Hpricot-like convenience methods for LibXml
  class XML::Document
    def self.parse_string(xml)
      xml_parser = XML::Parser.string(xml)
      xml_parser.parse
    end
  end

  class XML::Node
    def at(xpath)
      self.find_first(xpath)
    end

    # find the array of child nodes matching the given xpath
    # TODO add these to Rexml?
    def search(xpath)
      results = self.find(xpath).to_a
      if block_given?
        results.each do |result|
          yield result
        end
      end
      return results
    end

    def inner_xml
      child.to_s
    end
    alias inner_html inner_xml

    def inner_text
      self.content
    end
  end #XML::Node
  
  # And use XML::Node for our XML generation
  XTF::XML::Element = XML::Node
#   raise LoadError
rescue LoadError => e # If we can't load either rubygems or libxml-ruby
  
  # Just use REXML.
  require 'rexml/document'
  XTF::XML::Element = REXML::Element
  
end