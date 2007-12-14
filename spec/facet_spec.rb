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

describe "Facet" do
  it "should have 'tag_name' of 'facet'" do
    @facet = Facet.new("field_name")
    @facet.tag_name.should == 'facet'
  end
  
  it "should take the 'field' value as either a String or a Hash argument to 'new'" do
    @facet = Facet.new("value")
    @facet.field.should == "value"
    @facet.attributes[:field].should == "value"
    
    @f = Facet.new(:field => "value")
    @f.field.should == "value"
    @f.attributes[:field].should == "value"    
  end
  
  it "should raise an error if no :field present in 'attributes'" do
    lambda { Facet.new }.should raise_error(ArgumentError)
    
    lambda { Facet.new('value') }.should_not raise_error(ArgumentError)
    lambda { Facet.new(:field => "value") }.should_not raise_error(ArgumentError)
  end
  
  it "should render its XML representation properly" do
    @facet = Facet.new("title-facet", :select => "*[1-5]", :sort_groups_by => "value", :sort_docs_by => "-title", :include_empty_groups => "yes")
    expected = "<facet field='title-facet' select='*[1-5]' sort_groups_by='value' sort_docs_by='-title' include_empty_groups='yes'/>"
    # TODO these comparisons are not working in the way I expected them to.
    # REXML::Document.new(@facet.to_xml).write([]).first.should == REXML::Document.new(expected).write([]).first
  end
end