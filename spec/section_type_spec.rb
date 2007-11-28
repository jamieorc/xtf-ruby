require File.dirname(__FILE__) + '/spec_helper'

include XTF::Element

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
    
    @st = SectionType.new(Clause.new("and"))
    @st.content.should be_a_kind_of(Clause)
  end
  
  it "should render it's XML representation properly when 'content' is a Term" do
    @st = SectionType.new(Term.new("word"))
    REXML::Document.new(@st.to_xml).write([]).first.should == REXML::Document.new("<sectionType> <term>word</term> </sectionType>").write([]).first
  end
  
  it "should render it's XML representation properly when 'content' is a Clause" do
    @st = SectionType.new
    clause = Clause.new("and")
    clause.content = [Term.new("word"), Term.new("digit")]
    @st.content = clause
    expected = "<sectionType> <and> <term>word</term> <term>digit</term> </and> </sectionType>"
    REXML::Document.new(@st.to_xml).write([]).first.should == REXML::Document.new(expected).write([]).first
  end
end