require File.dirname(__FILE__) + '/spec_helper'

include XTF::Element

describe "Or" do
  before(:each) do
    @or = Or.new()
  end
  it "should have attribute_keys: :field, :fields, :max_snippets, :boost, :slop" do
    @or.attribute_keys.should == XTF::Element::Base::BASE_ATTRIBUTE_KEYS + [:fields, :slop]
  end
  
  it "should have an Array for content()" do
    @or.content.should be_kind_of(Array)
  end
end

describe "Or.new" do
  it "should accept :field or :fields, but not both. Raise an error if both provided" do
    lambda { Or.new(:field => "field") }.should_not raise_error(ArgumentError)
    lambda { Or.new(:fields => "one, two", :slop => "8") }.should_not raise_error(ArgumentError)
    lambda { Or.new(:field => "field", :fields => "one, two", :slop => "8") }.should raise_error(ArgumentError)
  end

  it "should require :slop attribute if :fields is provided, or vice-versa" do
    lambda { Or.new(:fields => "one, two") }.should raise_error(ArgumentError)
    lambda { Or.new(:slop => "8") }.should raise_error(ArgumentError)
    lambda { Or.new(:fields => "one, two", :slop => "8") }.should_not raise_error(ArgumentError)

    @clause = Or.new(:fields => "one, two", :slop => "8", :max_snippets => "4")    
  end
  
end