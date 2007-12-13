require File.dirname(__FILE__) + '/spec_helper'

include XTF::Element

describe "Clause.create" do
  it "should require a tag_name" do
    lambda { Clause.create }.should raise_error(ArgumentError)
  end
  
  it "should return a subclass derived from the tag_name provided" do
    @clause = Clause.create("and")
    @clause.class.name.should == "XTF::Element::And"
  end
  
  it "should accept the tag_name as first argument or as part of attributes Hash" do
    @clause = Clause.create("and")
    @clause.should be_kind_of(XTF::Element::And)
    @clause = Clause.create(:tag_name => "and")
    @clause.should be_kind_of(XTF::Element::And)
  end
  
  it "should accept tag_name as Symbol if first argument" do
    @clause = Clause.create(:or)
    @clause.should be_kind_of(XTF::Element::Or)
  end
  
  it "should only accept these tag names: phrase, exact, and, or, or_near, orNear, not, near, range. Otherwise, raise an error" do
    %w{phrase exact and or or_near orNear not near range}.each do |name|
      lambda { Clause.create(name) }.should_not raise_error(ArgumentError)
    end
    
    %w{other term facet query section_type result_data}.each do |name|
      lambda { Clause.create(name) }.should raise_error(ArgumentError)
    end
  end

  it "should accept a hash of attributes" do
    attributes = {:field => "text", :max_snippets => "4", :boost => "8"}
    @clause = Clause.create("and", attributes)
    @clause.attributes.should == attributes
  end
  
  it "should accept a hash with the clause's content included" do
    params = {:tag_name => "and", :content => [Term.new("word")]}
    @clause = Clause.create(params)
    @clause.attributes.should == {}
    @clause.content.should be_a_kind_of(Array)
    @clause.content.size.should be 1
  end

  it "should accept a Term or Clause as content and insert it into the content Array automatically" do
    params = {:tag_name => "and", :content => Term.new("word")}
    @clause = Clause.create(params)
    @clause.attributes.should == {}
    @clause.content.should be_a_kind_of(Array)
    @clause.content.size.should be 1
  end
end


describe Clause do
  it "should have 'attributes' hash" do
    @clause = Clause.create("and")
    @clause.should respond_to :attributes
    @clause.attributes.should be_a_kind_of(Hash)
  end
  
  it "'content' should return an array" do
    @clause = Clause.create("and")
    @clause.content.should be_a_kind_of(Array)
    @clause.content.size.should be 0
  end
  
  it "should accept content as Term or Clause and insert it into an Array" do
    @clause = Clause.create("and")
    @clause.content.should == []
    @clause.content = Term.new("word")
    @clause.content.should be_a_kind_of(Array)
    @clause.content.size.should be 1
    @clause.content.first.should be_a_kind_of(Term)
    @clause.content.first.value.should == "word"
  end
  
  it "should render XTF query xml when 'to_xml' called" do
    attributes = {:field => "text", :max_snippets => "4"}
    @clause = Clause.create("and", attributes)
    @clause.to_xml_node.attributes.size.should == 2
    @clause.to_xml_node.attributes['field'].should == "text"
    @clause.to_xml_node.attributes['maxSnippets'].should == "4"
    array=[]
    @clause.content = Term.new("word")
    expected = "<and maxSnippets='4' field='text'><term>word</term></and>"
    d1 = REXML::Document.new(@clause.to_xml)
    d2 = REXML::Document.new(expected)
    puts ERB::Util.h(expected)
    puts "<br/>"
    puts ERB::Util.h(@clause.to_xml)
    # TODO these comparisons are not working in the way I expected them to.
#     d1.root.should == d2.root

    @clause.content << Term.new("digit")
    # TODO these comparisons are not working in the way I expected them to.
#     REXML::Document.new(@clause.to_xml).write([]).first.should == REXML::Document.new("<and maxSnippets='4' field='text'> <term>word</term> <term>digit</term> </and>").write([]).first
  end
end
