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

describe "Or" do
  before(:each) do
    @or = Or.new()
  end
  it "should have attribute_keys: :field, :fields, :max_snippets, :boost, :slop" do
    @or.attribute_keys.should == XTF::Search::Element::Base::BASE_ATTRIBUTE_KEYS + [:fields, :slop]
  end
  
  it "should have an Array for content()" do
    @or.content.should be_kind_of(Array)
  end
end

describe "Or.new" do
  it "should accept :field or :fields, but not both. Raise an error if both provided" do
    lambda { Or.new(:field => "field") }.should_not raise_error(ArgumentError)
    lambda { Or.new(:fields => "one, two", :slop => "8") }.should_not raise_error(ArgumentError)
    lambda { Or.new(:field => "field", :fields => "one, two", :slop => "8") }.should raise_error(ArgumentError)
  end

  it "should require :slop attribute if :fields is provided, or vice-versa" do
    lambda { Or.new(:fields => "one, two") }.should raise_error(ArgumentError)
    lambda { Or.new(:slop => "8") }.should raise_error(ArgumentError)
    lambda { Or.new(:fields => "one, two", :slop => "8") }.should_not raise_error(ArgumentError)

    @clause = Or.new(:fields => "one, two", :slop => "8", :max_snippets => "4")    
  end
  
end