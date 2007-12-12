require File.dirname(__FILE__) + '/spec_helper'

include XTF::Element

describe Base do
  before(:each) do
    @base = XTF::Element::Base.new
  end

  it "should have 'attributes' hash" do
  @base.should respond_to :attributes
  @base.attributes.should be_a_kind_of(Hash)
  end
end

describe Term do
  before(:each) do
    @term = XTF::Element::Term.new
  end
  
  it "'new' should accept a hash of attributes" do
    attributes = {:field => "text", :max_snippets => "4"}
    @term = Term.new(attributes)
    @term.attributes.should == attributes
  end
  
  it "'new' should accept a hash with the term's value included" do
    params = {:value => "term"}
    @term = Term.new(params)
    @term.attributes.should == {}
    @term.value.should == "term"
  end
  
  it "'new' should take a String as the first parameter and use the value as the value" do
    @term = Term.new("word")
    @term.value.should == "word"
  end
  
  it "'new' should ignore :value key in argument hash if String passed as first argument" do
    @term = Term.new("word", {:value => "NOT_USED"})
    @term.value.should == "word"
    @term.attributes[:value].should be_nil
  end
  
  it "should render XTF query xml when 'to_xml' called" do
    attributes = {:field => "text", :max_snippets => "4", :value => "term"}
    @term = Term.new(attributes)
    @term.to_xml_node.attributes.size.should == 2
    @term.to_xml_node.attributes['field'].should == "text"
    @term.to_xml_node.attributes['maxSnippets'].should == "4"
    @term.to_xml_node.text.should == "term"
  end

  it "should emit a phrase if the Term's value is surrounded by double-quotes" do
    @term = Term.new("\"some phrase\"")
    puts ERB::Util.h(@term.to_xml)
  end
end

