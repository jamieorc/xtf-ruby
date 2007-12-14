require File.dirname(__FILE__) + '/spec_helper'

include XTF::Element

describe Range do
  it "should have 'tag_name' of 'range'" do
    @range = XTF::Element::Range.new(1,2)
    @range.tag_name.should == "range"
  end
end

describe "Range.new" do
  it "should raise an error if no arguments are provided" do
    lambda { @range = XTF::Element::Range.new }.should raise_error(ArgumentError)
  end
  it "should accept lower as first and upper as second arguments" do
    lambda { @range = XTF::Element::Range.new(1,2) }.should_not raise_error(ArgumentError)
  end
  
  it "should raise an error if only one argument or one argument before Hash argument is passed" do
    lambda { @range = XTF::Element::Range.new(1) }.should raise_error(ArgumentError)
    lambda { @range = XTF::Element::Range.new(1, :boost => 2) }.should raise_error(ArgumentError)
  end
  
  it "should accept lower and upper as part of attributes Hash" do
    lambda { @range = XTF::Element::Range.new(:lower => 1, :upper => 2) }.should_not raise_error(ArgumentError)
  end
  
  it "should raise an error if one of lower/upper pair is passed as argument and the other is passed as Hash member" do
    lambda { @range = XTF::Element::Range.new(1, :upper => 2) }.should raise_error(ArgumentError)
  end
  
  it "should accept lower and upper as integers or Strings and convert them to Strings" do
    lambda { @range = XTF::Element::Range.new(1, 2) }.should_not raise_error(ArgumentError)
    @range.lower.should be_kind_of(String)
    @range.upper.should be_kind_of(String)
    lambda { @range = XTF::Element::Range.new("1", "2") }.should_not raise_error(ArgumentError)
    lambda { @range = XTF::Element::Range.new(:lower => 1, :upper => 2) }.should_not raise_error(ArgumentError)
    @range.lower.should be_kind_of(String)
    @range.upper.should be_kind_of(String)
    lambda { @range = XTF::Element::Range.new(:lower => "1", :upper => "2") }.should_not raise_error(ArgumentError)
  end
  
  it "should output proper xml" do
    @range = XTF::Element::Range.new(:lower => "1", :upper => "2", :inclusive => "yes", :numeric => "yes")
    puts ERB::Util.h(@range.to_xml)
  end
end