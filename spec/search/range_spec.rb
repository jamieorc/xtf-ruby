# Copyright 2007 James (Jamie) Orchard-Hays
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require File.dirname(__FILE__) + '/../spec_helper'

include XTF::Search::Element

describe Range do
  it "should have 'tag_name' of 'range'" do
    @range = XTF::Search::Element::Range.new(1,2)
    @range.tag_name.should == "range"
  end
end

describe "Range.new" do
  it "should raise an error if no arguments are provided" do
    lambda { @range = XTF::Search::Element::Range.new }.should raise_error(ArgumentError)
  end
  it "should accept lower as first and upper as second arguments" do
    lambda { @range = XTF::Search::Element::Range.new(1,2) }.should_not raise_error(ArgumentError)
  end
  
  it "should raise an error if only one argument or one argument before Hash argument is passed" do
    lambda { @range = XTF::Search::Element::Range.new(1) }.should raise_error(ArgumentError)
    lambda { @range = XTF::Search::Element::Range.new(1, :boost => 2) }.should raise_error(ArgumentError)
  end
  
  it "should accept lower and upper as part of attributes Hash" do
    lambda { @range = XTF::Search::Element::Range.new(:lower => 1, :upper => 2) }.should_not raise_error(ArgumentError)
  end
  
  it "should raise an error if one of lower/upper pair is passed as argument and the other is passed as Hash member" do
    lambda { @range = XTF::Search::Element::Range.new(1, :upper => 2) }.should raise_error(ArgumentError)
  end
  
  it "should accept lower and upper as integers or Strings and convert them to Strings" do
    lambda { @range = XTF::Search::Element::Range.new(1, 2) }.should_not raise_error(ArgumentError)
    @range.lower.should be_kind_of(String)
    @range.upper.should be_kind_of(String)
    lambda { @range = XTF::Search::Element::Range.new("1", "2") }.should_not raise_error(ArgumentError)
    lambda { @range = XTF::Search::Element::Range.new(:lower => 1, :upper => 2) }.should_not raise_error(ArgumentError)
    @range.lower.should be_kind_of(String)
    @range.upper.should be_kind_of(String)
    lambda { @range = XTF::Search::Element::Range.new(:lower => "1", :upper => "2") }.should_not raise_error(ArgumentError)
  end
  
  it "should output proper xml" do
    @range = XTF::Search::Element::Range.new(:lower => "1", :upper => "2", :inclusive => "yes", :numeric => "yes")
    puts ERB::Util.h(@range.to_xml) if Kernel.const_defined?(:ERB) #runs in TextMate, not Rake
  end
end