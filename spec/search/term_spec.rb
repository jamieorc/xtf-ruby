require "spec_helper"

include XTF::Search::Element

RSpec.describe "Term.new" do

  it "should accept a hash of attributes" do
    attributes = {:field => "text", :max_snippets => "4"}
    @term = Term.new(attributes)
    expect(@term.attributes).to eq attributes
  end

  it "should accept a hash with the term's value included" do
    params = {:value => "term"}
    @term = Term.new(params)
    expect(@term.attributes).to be_a Hash
    expect(@term.attributes).to be_empty
    expect(@term.value).to eq "term"
  end

  it "should take a String as the first parameter and use the value as the value" do
    @term = Term.new("word")
    expect(@term.value).to eq "word"
  end

  it "should accept :section_type as part of the attributes hash and set the accessor's value" do
    @term = XTF::Search::Element::Term.new(:section_type => "section")
    expect(@term.section_type).to eq "section"
  end

  it "should ignore :value key in argument hash if String passed as first argument" do
    @term = Term.new("word", {:value => "NOT_USED"})
    expect(@term.value).to eq "word"
    expect(@term.attributes[:value]).to be nil
  end

  it "should accept :parse_phrase as parameter." do
    @term = Term.new({:value => "some phrase", :parse_phrase => false})
    expect(@term.to_xml).to eq "<term>some phrase</term>"
  end
end

RSpec.describe "Term parse_phrase" do
  it "should not parse a into a phrase if false" do
    @term = Term.new("some phrase")
    @term.parse_phrase = false
    expect(@term.to_xml).to eq "<term>some phrase</term>"
  end

  it "should default to false" do
    @term = Term.new("some phrase")
    expect(@term.parse_phrase).to be false
  end
end

RSpec.describe Term do
  before(:each) do
    @term = XTF::Search::Element::Term.new
  end

  it "should render XTF query xml when 'to_xml' called" do
    attributes = {:field => "text", :max_snippets => "4", :value => "term"}
    @term = Term.new(attributes)
    expect(@term.to_xml_node.attributes.size).to eq 2
    expect(@term.to_xml_node.attributes['field']).to eq "text"
    expect(@term.to_xml_node.attributes['maxSnippets']).to eq "4"
    expect(@term.to_xml_node.text).to eq "term"
  end

  it "should emit a phrase if the Term's value is has multiple terms separated by a whitespace, hyphen, forward-slash, back-slash, period, comma, colon, semi-colon and strip double quotes at each end and :parse_phrase set to true" do
    @term = Term.new("\" some phrase with-hyphen forward/slash back\\slash comma, period. colon: semicolon;\"", :parse_phrase => true)
    result = @term.to_xml
    expect(result).not_to match /"/
    expect(result).to match /<phrase>\s*<term>some<\/term>\s*<term>phrase<\/term>\s*<term>with<\/term>\s*<term>hyphen<\/term>\s*<term>forward<\/term>\s*<term>slash<\/term>\s*<term>back<\/term>\s*<term>slash<\/term>\s*<term>comma<\/term>\s*<term>period<\/term>\s*<term>colon<\/term>\s*<term>semicolon<\/term>\s*<\/phrase>/
  end
end
