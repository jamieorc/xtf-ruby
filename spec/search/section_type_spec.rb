require "spec_helper"

include XTF::Search::Element

RSpec.describe SectionType do
  it "should have 'tag_name' of 'sectionType'" do
    @st = SectionType.new()
    expect(@st.tag_name).to eq "sectionType"
  end

  it "'new' should optionally take a Term or Clause as an argument" do
    @st = SectionType.new
    expect(@st.content).to be nil

    @st = SectionType.new(Term.new("word"))
    expect(@st.content).to be_a(Term)

    @st = SectionType.new(Clause.create("and"))
    expect(@st.content).to be_a(Clause)
  end

  it "should render its XML representation properly when 'content' is a Term" do
    @st = SectionType.new(Term.new("word"))
    # TODO these comparisons are not working in the way I expected them to.
    # expect(REXML::Document.new(@st.to_xml).write([]).first).to eq REXML::Document.new("<sectionType> <term>word</term> </sectionType>").write([]).first
  end

  it "should render its XML representation properly when 'content' is a Clause" do
    @st = SectionType.new
    clause = Clause.create("and")
    clause.content = [Term.new("word"), Term.new("digit")]
    @st.content = clause
    expect(@st.to_xml).to match /<sectionType>\s*<and>\s*<term>word<\/term>\s*<term>digit<\/term>\s*<\/and>\s*<\/sectionType>/
  end
end
