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
  
  # And use XML::Node for our XML generation
  XTF::XML::Element = XML::Node
#   raise LoadError
rescue LoadError => e # If we can't load either rubygems or libxml-ruby
  
  # Just use REXML.
  require 'rexml/document'
  XTF::XML::Element = REXML::Element
  
end