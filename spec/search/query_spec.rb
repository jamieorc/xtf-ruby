require "spec_helper"

include XTF::Search::Element

RSpec.describe Query do
  it "should have 'tag_name' of 'query'" do
    @query = Query.new
    expect(@query.tag_name).to eq "query"
  end

  it "should have a default style attribute of 'style/crossQuery/resultFormatter/default/resultFormatter.xsl'" do
    @query = Query.new
    expect(@query.attributes[:style]).to eq "style/crossQuery/resultFormatter/default/resultFormatter.xsl"
  end

  it "should have a default index_path attribute of 'index'" do
    @query = Query.new
    expect(@query.attributes[:index_path]).to eq "index"
  end

  it "should accept content as Term or Clause and insert it into an Array" do
    @query = Clause.create("and")
    expect(@query.content).to eq []
    @query.content = Term.new("word")
    expect(@query.content).to be_an(Array)
    expect(@query.content.size).to eq 1
    expect(@query.content.first).to be_a(Term)
    expect(@query.content.first.value).to eq "word"
  end


  it "should render XTF query xml when 'to_xml' called" do
    attributes = {:field => "text", :max_snippets => "4", :start_doc => "1", :max_docs => "20"}
    @query = Query.new(attributes)
    @facet = Facet.new("title-facet", :select => "*[1-5]")
    @clause = Clause.create("and", :content => Term.new("word"))
    @query.content << @clause
    @query.content << @facet

    expected =<<-END
    <query field="text" maxSnippets="4" startDoc="1" maxDocs="20" style="style/crossQuery/resultFormatter/default/resultFormatter.xsl" indexPath="index">
      <and><term>word</term></and>
      <facet field="title-facet" select="*[1-5]"/>
    </query>
    END

    expect(@query.to_xml).to match /^<query[^>]+field="text"/
    expect(@query.to_xml).to match /^<query[^>]+maxSnippets="4"/
    expect(@query.to_xml).to match /^<query[^>]+startDoc="1"/
    expect(@query.to_xml).to match /^<query[^>]+maxDocs="20"/
    expect(@query.to_xml).to match /^<query[^>]+style="style\/crossQuery\/resultFormatter\/default\/resultFormatter.xsl"/
    expect(@query.to_xml).to match /^<query[^>]+indexPath="index"/

    expect(@query.to_xml).to match /<and>\s*<term>word<\/term>\s*<\/and>/

    expect(@query.to_xml).to match /<facet[^>]+field="title-facet"/
    expect(@query.to_xml).to match /<facet[^>]+select="\*\[1-5\]"/

    expect(@query.to_xml).to match /<\/query>/

    # TODO these comparisons are not working in the way I expected them to.
#     expect(REXML::Document.new(@query.to_xml).root.write([]).join('')).to eq REXML::Document.new(expected).root.write([]).join('')
#     puts ERB::Util.h(@query.to_xml) if Kernel.const_defined?(:ERB) #runs in TextMate, not Rake
#     puts ERB::Util.h(REXML::Document.new(expected).root.write([])) if Kernel.const_defined?(:ERB) #runs in TextMate, not Rake
#     puts ERB::Util.h(REXML::Document.new(@query.to_xml).root.write([])) if Kernel.const_defined?(:ERB) #runs in TextMate, not Rake
  end

end
