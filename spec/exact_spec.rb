require File.dirname(__FILE__) + '/spec_helper'

include XTF::Element

describe "Exact" do
  before(:each) do
    @exact = Exact.new()
  end
  it "should have attribute_keys: :field, :max_snippets, :boost" do
    @exact.attribute_keys.should == XTF::Element::Base::BASE_ATTRIBUTE_KEYS
  end
  
  it "should have an Array for content()" do
    @exact.content.should be_kind_of(Array)
  end
end
