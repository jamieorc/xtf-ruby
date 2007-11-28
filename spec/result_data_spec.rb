require File.dirname(__FILE__) + '/spec_helper'

include XTF::Element

describe ResultData do
  it "should have 'tag_name' of 'resultData'" do
    @rd = ResultData.new
    @rd.tag_name.should == 'resultData'
  end
  
  it "should accept the value of the result data as an argument to 'new'" do
    @rd = ResultData.new("the result data value")
    @rd.value.should == "the result data value"
  end
  
  it "should allow setting of the value" do
    @rd = ResultData.new
    @rd.value.should be_nil
    @rd.value = "the result data value"
    @rd.value.should == "the result data value"
  end
  
  it "should output proper XTF XML" do
    @rd = ResultData.new("the result data value")
    expected = "<resultData>the result data value</resultData>"
    # TODO these comparisons are not working in the way I expected them to.
    # REXML::Document.new(@rd.to_xml).write([]).first.should == REXML::Document.new(expected).write([]).first
  end
  
end