require File.dirname(__FILE__) + '/spec_helper'

include XTF::Element

describe "OrNear" do
  before(:each) do
    @orNear = OrNear.new("8")
  end
  it "should have attribute_keys: :field, :max_snippets, :boost, :slop" do
    @orNear.attribute_keys.should == XTF::Element::Base::BASE_ATTRIBUTE_KEYS + [:slop]
  end
  
  it "should have an Array for content()" do
    @orNear.content.should be_kind_of(Array)
  end
end

describe "OrNear.new" do
  it "should raise an error if no slop provided" do
    lambda { OrNear.new(:slop => "8") }.should_not raise_error(ArgumentError)
    lambda { OrNear.new("8") }.should_not raise_error(ArgumentError)
    lambda { OrNear.new() }.should raise_error(ArgumentError)
  end
  
end