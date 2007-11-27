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

describe Clause do
  before(:each) do
    @base = @clause = XTF::Element::Clause.new
  end
  
end

describe Term do
  before(:each) do
    @base = @term = XTF::Element::Term.new
  end
  
  
  it "should respond to 'value' and 'section_type' attributes" do
#     @term.should respond_to :value, :section_type
  end
  
  it "should optionally take attributes as arguments when instantiated" do
#     @term = XTF::Element::Term.new(:field => "text", :max_snippets => "4",  :boost => "6", :value => "value")
#     @term.field.should == "text"
#     @term.max_snippets.should == "4"
#     @term.boost.should == "6"
#     @term.value.should == "value"
  end
  
  it "'value' should be one word without white-space" do
    
  end
end