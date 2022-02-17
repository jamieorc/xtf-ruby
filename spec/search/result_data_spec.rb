require "spec_helper"

include XTF::Search::Element

RSpec.describe ResultData do
  it "should have 'tag_name' of 'resultData'" do
    @rd = ResultData.new
    expect(@rd.tag_name).to eq 'resultData'
  end

  it "should accept the value of the result data as an argument to 'new'" do
    @rd = ResultData.new("the result data value")
    expect(@rd.value).to eq "the result data value"
  end

  it "should allow setting of the value" do
    @rd = ResultData.new
    expect(@rd.value).to be nil
    @rd.value = "the result data value"
    expect(@rd.value).to eq "the result data value"
  end

  it "should output proper XTF XML" do
    @rd = ResultData.new("the result data value")
    expected = "<resultData>the result data value</resultData>"
    expect(expected).to eq "<resultData>the result data value</resultData>"
  end

end
