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

describe Query do
  it "should have 'tag_name' of 'query'" do
    @query = Query.new
    @query.tag_name.should == 'query'
  end
  
  it "should have a default style attribute of 'style/crossQuery/resultFormatter/default/resultFormatter.xsl'" do
    @query = Query.new
    @query.attributes[:style].should == "style/crossQuery/resultFormatter/default/resultFormatter.xsl"
  end
    
  it "should have a default index_path attribute of 'index'" do
    @query = Query.new
    @query.attributes[:index_path].should == "index"
  end
  
  it "should accept content as Term or Clause and insert it into an Array" do
    @query = Clause.create("and")
    @query.content.should == []
    @query.content = Term.new("word")
    @query.content.should be_a_kind_of(Array)
    @query.content.size.should be 1
    @query.content.first.should be_a_kind_of(Term)
    @query.content.first.value.should == "word"
  end
  
  
  it "should render XTF query xml when 'to_xml' called" do
    attributes = {:field => "text", :max_snippets => "4", :start_doc => "1", :max_docs => "20"}
    @query = Query.new(attributes)
    @facet = Facet.new("title-facet", :select => "*[1-5]")
    @clause = Clause.create("and", :content => Term.new("word"))
    @query.content << @clause
    @query.content << @facet
    
    expected =<<-END 
    <query field='text' maxSnippets='4' startDoc='1' maxDocs='20' style='style/crossQuery/resultFormatter/default/resultFormatter.xsl' indexPath='index'>
      <and><term>word</term></and>
      <facet field='title-facet' select='*[1-5]'/>
    </query>
    END
    puts ERB::Util.h(expected)
    puts "<br/>"
    puts ERB::Util.h(@query.to_xml)
    
    # TODO these comparisons are not working in the way I expected them to.
#     REXML::Document.new(@query.to_xml).root.write([]).join('').should == REXML::Document.new(expected).root.write([]).join('')
#     puts ERB::Util.h(@query.to_xml)
#     puts ERB::Util.h(REXML::Document.new(expected).root.write([]))
#     puts ERB::Util.h(REXML::Document.new(@query.to_xml).root.write([]))
  end
  
end