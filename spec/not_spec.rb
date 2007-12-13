require File.dirname(__FILE__) + '/spec_helper'

include XTF::Element

describe "Not" do
  before(:each) do
    @not = Not.new()
  end
  it "should have attribute_keys: :field, :max_snippets, :boost" do
    @not.attribute_keys.should == XTF::Element::Base::BASE_ATTRIBUTE_KEYS
  end
  
  it "should have an Array for content()" do
    @not.content.should be_kind_of(Array)
  end
end
