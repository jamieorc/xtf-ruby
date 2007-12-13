require File.dirname(__FILE__) + '/spec_helper'

include XTF::Element

describe "Near" do
  before(:each) do
    @near = Near.new("8")
  end
  it "should have attribute_keys: :field, :max_snippets, :boost, :slop" do
    @near.attribute_keys.should == XTF::Element::Base::BASE_ATTRIBUTE_KEYS + [:slop]
  end
  
  it "should have an Array for content()" do
    @near.content.should be_kind_of(Array)
  end
end

describe "Near.new" do
  it "should raise an error if no slop provided" do
    lambda { Near.new(:slop => "8") }.should_not raise_error(ArgumentError)
    lambda { Near.new("8") }.should_not raise_error(ArgumentError)
    lambda { Near.new() }.should raise_error(ArgumentError)
  end
  
end