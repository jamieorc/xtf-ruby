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

  it "should take a :phrase attribute, tokenize it and create Terms" do
    @exact = Exact.new(:phrase => "this is a phrase")
    result = @exact.to_xml
    puts ERB::Util.h(result)
  end
end

describe "Exact#phrase=" do
  before(:each) do
    @exact = Exact.new()
  end
  it "should raise an ArgumentError unless argument is a String" do
    lambda { @exact.phrase = :something }.should raise_error(ArgumentError)
    lambda { @exact.phrase="some words" }.should_not raise_error(ArgumentError)

  end

  it "should take a String, tokenize it and create Terms" do
    @exact.phrase = "this is a phrase"
    result = @exact.to_xml
    puts ERB::Util.h(result)
  end
end

