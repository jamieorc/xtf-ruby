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

describe "Phrase" do
  before(:each) do
    @phrase = Phrase.new()
  end
  it "should have attribute_keys: :field, :max_snippets, :boost" do
    @phrase.attribute_keys.should == XTF::Search::Element::Base::BASE_ATTRIBUTE_KEYS
  end
  
  it "should have an Array for content()" do
    @phrase.content.should be_kind_of(Array)
  end

  it "should take a :phrase attribute, tokenize it and create Terms" do
    @phrase = Phrase.new(:phrase => "this is a phrase")
    result = @phrase.to_xml
    puts ERB::Util.h(result) if Kernel.const_defined?(:ERB) #runs in TextMate, not Rake
  end
end

describe "Phrase#phrase=" do
  before(:each) do
    @phrase = Phrase.new()
  end
  it "should raise an ArgumentError unless argument is a String" do
    lambda { @phrase.phrase = :something }.should raise_error(ArgumentError)
    lambda { @phrase.phrase="some words" }.should_not raise_error(ArgumentError)
    
  end
  
  it "should take a String, tokenize it and create Terms" do
    @phrase.phrase = "this is a phrase"
    result = @phrase.to_xml
    puts ERB::Util.h(result) if Kernel.const_defined?(:ERB) #runs in TextMate, not Rake
  end
  
  it "should move solitary wildcard to previous term" do
    @phrase.phrase="some words,*"
    @phrase.to_xml.should =~ /<phrase>\s*<term>some<\/term>\s*<term>words\*<\/term>\s*<\/phrase>/
  end
end
