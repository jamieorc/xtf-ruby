require File.dirname(__FILE__) + '/spec_helper'

include XTF::Element

describe "Base", :shared => true do
  it "should have 'field', 'max_snippets', 'boost' and 'section_type' methods" do
    @base.should respond_to :field, :max_snippets, :boost, :section_type
  end
end

describe Base do
  before(:each) do
    @base = XTF::Element::Base.new
  end
  it_should_behave_like "Base"
  
  it "'attributes_hash' and 'attributes' should be the same size" do
    @base.attributes_hash.size.should == @base.class.attributes.size
  end
end

describe Clause do
  before(:each) do
    @base = @clause = XTF::Element::Clause.new
  end
  
  it_should_behave_like "Base"
end

describe Term do
  before(:each) do
    @base = @term = XTF::Element::Term.new
  end
  
  it_should_behave_like "Base"
  
  it "should respond to 'value' and 'section_type' attributes" do
    @term.should respond_to :value, :section_type
  end
  
  it "should optionally take attributes as arguments when instantiated" do
    @term = XTF::Element::Term.new(:field => "text", :max_snippets => "4",  :boost => "6", :value => "value")
    @term.field.should == "text"
    @term.max_snippets.should == "4"
    @term.boost.should == "6"
    @term.value.should == "value"
  end
  
  it "'value' should be one word without white-space" do
    
  end
end