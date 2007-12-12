require File.dirname(__FILE__) + '/spec_helper'

include XTF::Element

describe Range do
  it "should have 'tag_name' of 'range'" do
    @range = XTF::Element::Range.new
    @range.tag_name.should == "range"
  end
end