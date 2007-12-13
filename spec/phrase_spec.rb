require File.dirname(__FILE__) + '/spec_helper'

include XTF::Element

describe "Phrase" do
  before(:each) do
    @phrase = Phrase.new()
  end
  it "should have attribute_keys: :field, :max_snippets, :boost" do
    @phrase.attribute_keys.should == XTF::Element::Base::BASE_ATTRIBUTE_KEYS
  end
  
  it "should have an Array for content()" do
    @phrase.content.should be_kind_of(Array)
  end
end
