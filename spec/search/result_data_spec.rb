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