require "spec_helper"

include XTF::Search::Element

RSpec.describe "Clause.create" do
  it "should require a tag_name" do
    expect { Clause.create }.to raise_error ArgumentError
  end

  it "should return a subclass derived from the tag_name provided" do
    @clause = Clause.create("and")
    expect(@clause.class.name).to eq "XTF::Search::Element::And"
  end

  it "should accept the tag_name as first argument or as part of attributes Hash" do
    @clause = Clause.create("and")
    expect(@clause).to be_an(XTF::Search::Element::And)
    @clause = Clause.create(:tag_name => "and")
    expect(@clause).to be_an(XTF::Search::Element::And)
  end

  it "should accept tag_name as Symbol if first argument" do
    @clause = Clause.create(:or)
    expect(@clause).to be_an(XTF::Search::Element::Or)
  end

  it "should accept :term as a String or Term and create a Term instance in content" do
    @clause = Clause.create(:or, :term => "word")
    expect(@clause.content.first.to_xml).to eq "<term>word</term>"
    expect(@clause.content.first).to be_a(Term)

    @c2 = Clause.create(:and, :term => Term.new("second"))
    expect(@c2.content.first.to_xml).to eq "<term>second</term>"
    expect(@c2.content.first).to be_a(Term)
  end

  it "should accept 'term=' as a String or Termand create a Term instance in content" do
    @clause = Clause.create(:or)
        @clause.term = "word"
        expect(@clause.content.first.to_xml).to eq "<term>word</term>"
        expect(@clause.content.first).to be_a(Term)

        @clause.term = Term.new("second")
        expect(@clause.content.last.to_xml).to eq "<term>second</term>"
        expect(@clause.content.last).to be_a(Term)
  end

  it "should only accept these tag names: phrase, exact, and, or, or_near, orNear, not, near, range. Otherwise, raise an error" do
    %w{phrase exact and or or_near orNear not near range}.each do |name|
      attributes = case name
      when "or_near", "orNear", "near"
        {:slop => "8"}
      when "range"
        {:lower => 1, :upper => 5}
      else
        {}
      end
      expect { Clause.create(name, attributes) }.not_to raise_error
    end

    %w{other term facet query section_type result_data}.each do |name|
      expect { Clause.create(name) }.to raise_error ArgumentError
    end
  end

  it "should accept a hash of attributes" do
    attributes = {:field => "text", :max_snippets => "4", :boost => "8"}
    @clause = Clause.create("and", attributes)
    expect(@clause.attributes).to eq attributes
  end

  it "should accept a hash with the clause's content included" do
    params = {:tag_name => "and", :content => [Term.new("word")]}
    @clause = Clause.create(params)
    expect(@clause.attributes).to be_a Hash
    expect(@clause.attributes).to be_empty
    expect(@clause.content).to be_an(Array)
    expect(@clause.content.size).to eq 1
  end

  it "should accept a Term or Clause as content and insert it into the content Array automatically" do
    params = {:tag_name => "and", :content => Term.new("word")}
    @clause = Clause.create(params)
    expect(@clause.attributes).to be_a Hash
    expect(@clause.attributes).to be_empty
    expect(@clause.content).to be_an(Array)
    expect(@clause.content.size).to eq 1
  end
end


RSpec.describe Clause do
  it "should have 'attributes' hash" do
    @clause = Clause.create("and")
    expect(@clause).to respond_to :attributes
    expect(@clause.attributes).to be_a(Hash)
  end

  it "'content' should return an array" do
    @clause = Clause.create("and")
    expect(@clause.content).to be_an(Array)
    expect(@clause.content.size).to eq 0
  end

  it "should accept content as Term or Clause and insert it into an Array" do
    @clause = Clause.create("and")
    expect(@clause.content).to eq []
    @clause.content = Term.new("word")
    expect(@clause.content).to be_an(Array)
    expect(@clause.content.size).to eq 1
    expect(@clause.content.first).to be_a(Term)
    expect(@clause.content.first.value).to eq "word"
  end

  it "should render XTF clause xml when 'to_xml' called" do
    attributes = {:field => "text", :max_snippets => "4"}
    @clause = Clause.create("and", attributes)
    expect(@clause.to_xml_node.attributes.size).to eq 2
    expect(@clause.to_xml_node.attributes['field']).to eq "text"
    expect(@clause.to_xml_node.attributes['maxSnippets']).to eq "4"
    result = @clause.to_xml
    # expected = "<and maxSnippets='4' field='text'></and>"
    expect(result).to match /<and[^>]+maxSnippets="4"[^>]*\/>/
    expect(result).to match /<and[^>]+field="text"[^>]*\/>/

    @clause.content = Term.new("word")
    result = @clause.to_xml
    # expected = "<and maxSnippets='4' field='text'><term>word</term></and>"
    expect(result).to include("<term>word</term>")

    @clause.content << Term.new("digit")
    result = @clause.to_xml
    # expected = "<and maxSnippets='4' field='text'><term>word</term><term>digit</term></and>"
    expect(result).to include("<term>word</term>")
    expect(result).to match /<and[^>]+>\s*<term>word<\/term>\s*<term>digit<\/term>\s*<\/and>/
  end
end
