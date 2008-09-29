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

describe SectionType do
  it "should have 'tag_name' of 'sectionType'" do
    @st = SectionType.new()
    @st.tag_name.should == "sectionType"
  end

  it "'new' should optionally take a Term or Clause as an argument" do
    @st = SectionType.new
    @st.content.should be_nil
    
    @st = SectionType.new(Term.new("word"))
    @st.content.should be_a_kind_of(Term)
    
    @st = SectionType.new(Clause.create("and"))
    @st.content.should be_a_kind_of(Clause)
  end
  
  it "should render its XML representation properly when 'content' is a Term" do
    @st = SectionType.new(Term.new("word"))
    # TODO these comparisons are not working in the way I expected them to.
    # REXML::Document.new(@st.to_xml).write([]).first.should == REXML::Document.new("<sectionType> <term>word</term> </sectionType>").write([]).first
  end
  
  it "should render its XML representation properly when 'content' is a Clause" do
    @st = SectionType.new
    clause = Clause.create("and")
    clause.content = [Term.new("word"), Term.new("digit")]
    @st.content = clause
    expected = "<sectionType> <and> <term>word</term> <term>digit</term> </and> </sectionType>"
    if Kernel.const_defined?(:ERB) #runs in TextMate, not Rake
      puts ERB::Util.h(expected)
      puts "<br/>"
      puts ERB::Util.h(@st.to_xml)
    end
    
    # TODO these comparisons are not working in the way I expected them to.
#     REXML::Document.new(@st.to_xml).write([]).first.should == REXML::Document.new(expected).write([]).first
  end
end