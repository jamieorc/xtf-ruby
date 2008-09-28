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

describe "Term.new" do
  
  it "should accept a hash of attributes" do
    attributes = {:field => "text", :max_snippets => "4"}
    @term = Term.new(attributes)
    @term.attributes.should == attributes
  end

  it "should accept a hash with the term's value included" do
    params = {:value => "term"}
    @term = Term.new(params)
    @term.attributes.should == {}
    @term.value.should == "term"
  end

  it "should take a String as the first parameter and use the value as the value" do
    @term = Term.new("word")
    @term.value.should == "word"
  end
  
  it "should accept :section_type as part of the attributes hash and set the accessor's value" do
    @term = XTF::Element::Term.new(:section_type => "section")
    @term.section_type.should == "section"
  end

  it "should ignore :value key in argument hash if String passed as first argument" do
    @term = Term.new("word", {:value => "NOT_USED"})
    @term.value.should == "word"
    @term.attributes[:value].should be_nil
  end
  
  it "should accept :parse_phrase as parameter." do
    @term = Term.new({:value => "some phrase", :parse_phrase => false})
    @term.to_xml.should == "<term>some phrase</term>"
  end
end

describe "Term parse_phrase" do
  it "should not parse a into a phrase if false" do
    @term = Term.new("some phrase")
    @term.parse_phrase = false
    @term.to_xml.should == "<term>some phrase</term>"
  end
  
  it "should default to true" do
    @term = Term.new("some phrase")
    @term.parse_phrase.should be_true
  end
end

describe Term do
  before(:each) do
    @term = XTF::Element::Term.new
  end
  
  it "should render XTF query xml when 'to_xml' called" do
    attributes = {:field => "text", :max_snippets => "4", :value => "term"}
    @term = Term.new(attributes)
    @term.to_xml_node.attributes.size.should == 2
    @term.to_xml_node.attributes['field'].should == "text"
    @term.to_xml_node.attributes['maxSnippets'].should == "4"
    @term.to_xml_node.text.should == "term"
  end

  it "should emit a phrase if the Term's value is has multiple terms separated by a whitespace, hyphen, forward-slash, back-slash, period, comma, colon, semi-colon and strip double quotes at each end" do
    @term = Term.new("\" some phrase with-hyphen forward/slash back\\slash comma, period. colon: semicolon;\"")
    result = @term.to_xml
    result.should_not match(/"/)
    result.should match(/<phrase>\s*<term>some<\/term>\s*<term>phrase<\/term>\s*<term>with<\/term>\s*<term>hyphen<\/term>\s*<term>forward<\/term>\s*<term>slash<\/term>\s*<term>back<\/term>\s*<term>slash<\/term>\s*<term>comma<\/term>\s*<term>period<\/term>\s*<term>colon<\/term>\s*<term>semicolon<\/term>\s*<\/phrase>/)
    puts ERB::Util.h(result) if Kernel.const_defined?(:ERB) #runs in TextMate, not Rake
  end
end

