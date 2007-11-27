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
  
end

describe Clause do
  before(:each) do
    @base = @clause = XTF::Element::Clause.new
  end
  
end
