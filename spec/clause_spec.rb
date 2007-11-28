require File.dirname(__FILE__) + '/spec_helper'

include XTF::Element

describe Clause do
  it "should have 'attributes' hash" do
    @clause = Clause.new("and")
    @clause.should respond_to :attributes
    @clause.attributes.should be_a_kind_of(Hash)
  end
  
  it "should require a tag_name" do
    lambda { Clause.new }.should raise_error(ArgumentError)
  end
  
  it "'new' should accept a String or Symbol as first argument and use it as tag name. This should take precedence over :tag_name in args hash." do
    @clause = Clause.new("and")
    @clause.tag_name.should == "and"
    
    @clause = Clause.new(:or)
    @clause.tag_name.should == "or"
    
    @clause = Clause.new(:not, :tag_name => "and")
    @clause.tag_name.should == "not"
    @clause.attributes[:tag_name].should be_nil
  end
  
  it "should only accept these tag names: phrase, exact, and, or, or_near, not, near, range. Otherwise, raise an error" do
    %w{phrase exact and or or_near not near range}.each do |name|
      lambda { Clause.new(name) }.should_not raise_error(ArgumentError)
    end
    
    %w{other term facet query section_type result_data}.each do |name|
      lambda { Clause.new(name) }.should raise_error(ArgumentError)
    end
  end
  
  it "'new' should accept a hash of attributes" do
    attributes = {:field => "text", :max_snippets => "4", :boost => "8"}
    @clause = Clause.new("and", attributes)
    @clause.attributes.should == attributes
  end
  
  it "'content' should return an array" do
    @clause = Clause.new("and")
    @clause.content.should be_a_kind_of(Array)
    @clause.content.size.should be 0
  end

  it "'new' should accept a hash with the clause's content included" do
    params = {:tag_name => "and", :content => [Term.new("word")]}
    @clause = Clause.new(params)
    @clause.attributes.should == {}
    @clause.content.should be_a_kind_of(Array)
    @clause.content.size.should be 1
  end
  
  it "'new' should accept a Term or Clause as content and insert it into the content Array automatically" do
    params = {:tag_name => "and", :content => Term.new("word")}
    @clause = Clause.new(params)
    @clause.attributes.should == {}
    @clause.content.should be_a_kind_of(Array)
    @clause.content.size.should be 1
  end
  
  it "should accept content as Term or Clause and insert it into an Array" do
    @clause = Clause.new("and")
    @clause.content.should == []
    @clause.content = Term.new("word")
    @clause.content.should be_a_kind_of(Array)
    @clause.content.size.should be 1
    @clause.content.first.should be_a_kind_of(Term)
    @clause.content.first.value.should == "word"
  end
  
  it "should render XTF query xml when 'to_xml' called" do
    attributes = {:field => "text", :max_snippets => "4"}
    @clause = Clause.new("and", attributes)
    @clause.to_xml_node.attributes.size.should == 2
    @clause.to_xml_node.attributes['field'].should == "text"
    @clause.to_xml_node.attributes['maxSnippets'].should == "4"
    array=[]
    @clause.content = Term.new("word")
    d1 = REXML::Document.new(@clause.to_xml)
    d2 = REXML::Document.new("<and maxSnippets='4' field='text'><term>word</term></and>")
    d1.write([]).first.should == d2.write([]).first

    @clause.content << Term.new("digit")
    REXML::Document.new(@clause.to_xml).write([]).first.should == REXML::Document.new("<and maxSnippets='4' field='text'> <term>word</term> <term>digit</term> </and>").write([]).first
  end
end
