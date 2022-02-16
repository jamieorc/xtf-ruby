# Copyright 2008 James (Jamie) Orchard-Hays
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

require "spec_helper"
require "cgi"

# include XTF::Search::Element
class XTF::Result::Element::DocHit

end
RSpec.describe "Result" do

  before(:each) do
#     XTF::Search::Element::Base.new
#     XTF::Result::Element::DocHitBase.new(XML_DOC)
#     @doc = XTF::Result::Element::Result.new(XML_DOC)
  end

  it "should have query_time, total_docs, start_doc, end_doc" do
    @doc = XTF::Result::Element::Result.new(XML_DOC)
    expect(@doc.query_time).to eq "0.36"
    expect(@doc.total_docs).to eq "206"
    expect(@doc.start_doc).to eq "1"
    expect(@doc.end_doc).to eq "3"
    expect(@doc.docs_per_page).to eq "20"
  end

  it "'next_start_doc' should return sum of 'start_doc' and 'docs_per_page'" do
    @doc = XTF::Result::Element::Result.new(XML_DOC)
    @doc.instance_variable_set(:@start_doc, "21")
    @doc.instance_variable_set(:@docs_per_page, "20")
    expect(@doc.next_start_doc).to eq "41"
  end

  it "'next_start_doc' should return 'start_doc' if sum of 'start_doc' and 'docs_per_page' is more than 'total_docs'" do
    @doc = XTF::Result::Element::Result.new(XML_DOC)
    @doc.instance_variable_set(:@start_doc, "21")
    @doc.instance_variable_set(:@docs_per_page, "20")
    @doc.instance_variable_set(:@total_docs, "40")
    expect(@doc.next_start_doc).to eq "21"
  end

  it "'next_page_query_string' should return an accurate query string" do
    @doc = XTF::Result::Element::Result.new(XML_DOC)
    @doc.instance_variable_set(:@start_doc, "21")
    @doc.instance_variable_set(:@docs_per_page, "20")
    @doc.instance_variable_set(:@total_docs, "60")
    expect(CGI::parse(@doc.next_page_query_string)).to include("docsPerPage" => ["20"], "startDoc" => ["41"])
  end

  it "'previous_start_doc' should return difference of 'start_doc' and 'docs_per_page'" do
    @doc = XTF::Result::Element::Result.new(XML_DOC)
    @doc.instance_variable_set(:@start_doc, "21")
    @doc.instance_variable_set(:@docs_per_page, "20")
    expect(@doc.previous_start_doc).to eq "1"
  end

  it "'previous_start_doc' should return '1' if difference of 'start_doc' and 'docs_per_page' is less than 1" do
    @doc = XTF::Result::Element::Result.new(XML_DOC)
    @doc.instance_variable_set(:@start_doc, "1")
    @doc.instance_variable_set(:@docs_per_page, "20")
    expect(@doc.previous_start_doc).to eq "1"
  end

  it "'previous_page_query_string' should return an accurate query string" do
    @doc = XTF::Result::Element::Result.new(XML_DOC)
    @doc.instance_variable_set(:@start_doc, "21")
    @doc.instance_variable_set(:@docs_per_page, "20")
    @doc.instance_variable_set(:@total_docs, "60")
    expect(CGI::parse(@doc.previous_page_query_string)).to include("docsPerPage" => ["20"], "startDoc" => ["1"])
  end

  it "'last_start_doc' should return the number of the document that starts the last page" do
    @doc = XTF::Result::Element::Result.new(XML_DOC)
    @doc.instance_variable_set(:@start_doc, "1")
    @doc.instance_variable_set(:@docs_per_page, "20")

    @doc.instance_variable_set(:@total_docs, "97")
    expect(@doc.last_start_doc).to eq "81"

    @doc.instance_variable_set(:@total_docs, "100")
    expect(@doc.last_start_doc).to eq "81"

    @doc.instance_variable_set(:@total_docs, "101")
    expect(@doc.last_start_doc).to eq "101"

    @doc.instance_variable_set(:@total_docs, "1")
    expect(@doc.last_start_doc).to eq "1"
  end

  it "'total_pages' should return the total number of pages based on result count and docs per page" do
    @doc = XTF::Result::Element::Result.new(XML_DOC)
    @doc.instance_variable_set(:@start_doc, "1")
    @doc.instance_variable_set(:@docs_per_page, "20")

    @doc.instance_variable_set(:@total_docs, "97")
    expect(@doc.total_pages).to eq "5"

    @doc.instance_variable_set(:@total_docs, "100")
    expect(@doc.total_pages).to eq "5"

    @doc.instance_variable_set(:@total_docs, "101")
    expect(@doc.total_pages).to eq "6"

    @doc.instance_variable_set(:@total_docs, "1")
    expect(@doc.total_pages).to eq "1"

    # 50 docs per page
    @doc.instance_variable_set(:@docs_per_page, "50")

    @doc.instance_variable_set(:@total_docs, "97")
    expect(@doc.total_pages).to eq "2"

    @doc.instance_variable_set(:@total_docs, "100")
    expect(@doc.total_pages).to eq "2"

    @doc.instance_variable_set(:@total_docs, "101")
    expect(@doc.total_pages).to eq "3"

    @doc.instance_variable_set(:@total_docs, "1")
    expect(@doc.total_pages).to eq "1"
  end

  it "'start_doc_for_page' should return 'last_start_doc' if page >= 'total_pages'" do
    @doc = XTF::Result::Element::Result.new(XML_DOC)
    @doc.instance_variable_set(:@start_doc, "1")
    @doc.instance_variable_set(:@docs_per_page, "20")

    @doc.instance_variable_set(:@total_docs, "97")
    expect(@doc.start_doc_for_page(6)).to eq "81"
    expect(@doc.start_doc_for_page(5)).to eq "81"
    expect(@doc.start_doc_for_page(4)).not_to eq "81"
  end

  it "'start_doc_for_page' should return 'start_doc' if page <= 1" do
    @doc = XTF::Result::Element::Result.new(XML_DOC)
    @doc.instance_variable_set(:@start_doc, "1")
    @doc.instance_variable_set(:@docs_per_page, "20")

    @doc.instance_variable_set(:@total_docs, "97")
    expect(@doc.start_doc_for_page(1)).to eq "1"
    expect(@doc.start_doc_for_page(0)).to eq "1"
    expect(@doc.start_doc_for_page(4)).not_to eq "1"
  end

  it "'start_doc_for_page' should return proper start doc number" do
    @doc = XTF::Result::Element::Result.new(XML_DOC)
    @doc.instance_variable_set(:@start_doc, "1")
    @doc.instance_variable_set(:@docs_per_page, "20")

    @doc.instance_variable_set(:@total_docs, "97")
    expect(@doc.start_doc_for_page(2)).to eq "21"
    expect(@doc.start_doc_for_page(3)).to eq "41"
    expect(@doc.start_doc_for_page(4)).to eq "61"
    expect(@doc.start_doc_for_page(5)).to eq "81"

    @doc.instance_variable_set(:@docs_per_page, "50")
    @doc.instance_variable_set(:@total_docs, "107")
    expect(@doc.start_doc_for_page(2)).to eq "51"
    expect(@doc.start_doc_for_page(3)).to eq "101"
  end

  it "'current_page' should return correct page for current result set." do
    @doc = XTF::Result::Element::Result.new(XML_DOC)
    @doc.instance_variable_set(:@docs_per_page, "20")
    @doc.instance_variable_set(:@total_docs, "97")

    @doc.instance_variable_set(:@start_doc, "1")
    expect(@doc.current_page).to eq "1"

    @doc.instance_variable_set(:@start_doc, "21")
    expect(@doc.current_page).to eq "2"

    @doc.instance_variable_set(:@start_doc, "41")
    expect(@doc.current_page).to eq "3"

    @doc.instance_variable_set(:@start_doc, "61")
    expect(@doc.current_page).to eq "4"

    @doc.instance_variable_set(:@start_doc, "81")
    expect(@doc.current_page).to eq "5"
  end

  it "should have query and it should match the xml returned" do
    @doc = XTF::Result::Element::Result.new(XML_DOC)
    expected = XML::Document.parse_string(XML_DOC).root.at("//query").to_s.gsub(/\s+/, ' ')
    expect(@doc.query.gsub(/\s+/, ' ')).to eq expected
  end

  it "'hits' should be a list of DocHit instances" do
    @doc = XTF::Result::Element::Result.new(XML_DOC_OR_EXCLUDE)
    expect(@doc.hits.length).to eq 3
    @doc.hits.each { |h| expect(h.class).to eq XTF::Result::Element::DocHit }
  end

end
XML_DOC =<<-END
<?xml version="1.0" encoding="UTF-8"?>
<crossQueryResult queryTime="0.36" totalDocs="206" startDoc="1" endDoc="3">
  <query xmlns:session="java:org.cdlib.xtf.xslt.Session" indexPath="index" termLimit="1000" workLimit="1000000" style="style/crossQuery/resultFormatter/default/resultFormatter.xsl" startDoc="1" maxDocs="20">
    <spellcheck/>
    <and>
      <and field="document_type">
        <term>Article</term>
      </and>
      <and field="text" maxSnippets="3" maxContext="100">
        <term>good</term>
      </and>
    </and>
  </query>
  <docHit rank="1" path="default:beq/15-4/beq.div.15.4.66.xml" score="100" totalHits="96">
    <meta>
      <title>Corporate Character: Modern Virtue Ethics and The Virtuous Corporation</title>
      <volume>15</volume>
      <issue>4</issue>
      <creator>Geoff Moore</creator>
      <document_type>
        <snippet rank="1" score="100">
          <hit>
            <term>Article</term>
          </hit>
        </snippet>
      </document_type>
      <display-kind>dynaXML/TEI</display-kind>
      <sort-title>corporate character modern virtue ethics and the virtuous corporation</sort-title>
      <sort-creator>moore</sort-creator>
    </meta>
    <snippet rank="1" score="100" sectionType="head ">Case 4: The <hit><term>Good</term></hit> Bigot</snippet>
    <snippet rank="2" score="21">with excellence, focusing on those internal <hit><term>goods</term></hit> thereby obtainable, while warding off threats</snippet>
    <snippet rank="3" score="21">its own inordinate pursuit of external <hit><term>goods</term></hit> and from the corrupting power of other institutions</snippet>
  </docHit>
  <docHit rank="2" path="default:beq/8-4/beq.div.8.4.3.xml" score="97" totalHits="87">
    <meta>
      <title>: Theorising the Ethical Organization</title>
      <volume>8</volume>
      <issue>4</issue>
      <creator>Jane Collier</creator>
      <document_type>
        <snippet rank="1" score="100">
          <hit>
            <term>Article</term>
          </hit>
        </snippet>
      </document_type>
      <display-kind>dynaXML/TEI</display-kind>
      <sort-title>theorising the ethical organization</sort-title>
      <sort-creator>collier</sort-creator>
    </meta>
    <snippet rank="1" score="100" sectionType="head ">i) The "<hit><term>good</term></hit>" and the "right"</snippet>
    <snippet rank="2" score="100" sectionType="head ">iii) Practice: the locus of the "<hit><term>good</term></hit>"</snippet>
    <snippet rank="3" score="40">procedures, and the creation of a typology of the "<hit><term>goods</term></hit>" internal to the practice of management.</snippet>
  </docHit>
  <docHit rank="3" path="default:beq/16-1/beq.div.16.1.39.xml" score="93" totalHits="75">
    <meta>
      <title>THE VIRTUE OF COURAGE IN ENTREPRENEURSHIP: ENGAGING THE CATHOLIC SOCIAL TRADITION AND THE LIFE-CYCLE OF THE BUSINESS</title>
      <volume>16</volume>
      <issue>1</issue>
      <creator>Michael J. Naughton Jeffrey R. Cornwall</creator>
      <document_type>
        <snippet rank="1" score="100">
          <hit>
            <term>Article</term>
          </hit>
        </snippet>
      </document_type>
      <display-kind>dynaXML/TEI</display-kind>
      <sort-title>virtue of courage in entrepreneurship engaging the catholic social tradition and the lifecycle of the business</sort-title>
      <sort-creator>cornwall</sort-creator>
    </meta>
    <snippet rank="1" score="100">and a proper recognition of what is genuinely <hit><term>good</term></hit>. As we have seen in the vernacular understanding</snippet>
    <snippet rank="2" score="100">who can help the enterprise to stay the course toward <hit><term>good</term></hit> ends as the business evolves. In the next</snippet>
    <snippet rank="3" score="83">and rather settles for small or instrumental <hit><term>goods</term></hit> such as money. Evil and sin, as Thomas explains,</snippet>
  </docHit>
</crossQueryResult>
END

XML_DOC_OR_EXCLUDE =<<-END
<?xml version="1.0" encoding="UTF-8"?>
<crossQueryResult queryTime="0.041" totalDocs="207" startDoc="1" endDoc="20">
  <query xmlns:session="java:org.cdlib.xtf.xslt.Session" indexPath="index" termLimit="1000" workLimit="1000000" style="style/crossQuery/resultFormatter/default/resultFormatter.xsl" startDoc="1" maxDocs="20">
    <spellcheck/>
    <and>
      <and field="document_type">
        <term>Article</term>
      </and>
      <or field="text" maxSnippets="3" maxContext="100">
        <term>good</term>
        <term>bad</term>
        <not>
          <term>hate</term>
        </not>
      </or>
    </and>
  </query>
  <docHit rank="1" path="default:beq/15-4/beq.div.15.4.66.xml" score="100" totalHits="104">
    <meta>
      <title>Corporate Character: Modern Virtue Ethics and The Virtuous Corporation</title>
      <volume>15</volume>
      <issue>4</issue>
      <creator>Geoff Moore</creator>
      <document_type>
        <snippet rank="1" score="100">
          <hit>
            <term>Article</term>
          </hit>
        </snippet>
      </document_type>
      <display-kind>dynaXML/TEI</display-kind>
      <sort-title>corporate character modern virtue ethics and the virtuous corporation</sort-title>
      <sort-creator>moore</sort-creator>
    </meta>
    <snippet rank="1" score="100" sectionType="head ">Case 4: The <hit><term>Good</term></hit> Bigot</snippet>
    <snippet rank="2" score="21">with excellence, focusing on those internal <hit><term>goods</term></hit> thereby obtainable, while warding off threats</snippet>
    <snippet rank="3" score="21">its own inordinate pursuit of external <hit><term>goods</term></hit> and from the corrupting power of other institutions</snippet>
  </docHit>
  <docHit rank="2" path="default:beq/8-4/beq.div.8.4.3.xml" score="95" totalHits="87">
    <meta>
      <title>: Theorising the Ethical Organization</title>
      <volume>8</volume>
      <issue>4</issue>
      <creator>Jane Collier</creator>
      <document_type>
        <snippet rank="1" score="100">
          <hit>
            <term>Article</term>
          </hit>
        </snippet>
      </document_type>
      <display-kind>dynaXML/TEI</display-kind>
      <sort-title>theorising the ethical organization</sort-title>
      <sort-creator>collier</sort-creator>
    </meta>
    <snippet rank="1" score="100" sectionType="head ">i) The "<hit><term>good</term></hit>" and the "right"</snippet>
    <snippet rank="2" score="100" sectionType="head ">iii) Practice: the locus of the "<hit><term>good</term></hit>"</snippet>
    <snippet rank="3" score="40">procedures, and the creation of a typology of the "<hit><term>goods</term></hit>" internal to the practice of management.</snippet>
  </docHit>
  <docHit rank="3" path="default:beq/8-3/beq.div.8.3.115.xml" score="92" totalHits="48">
    <meta>
      <title>: THE ROLE OF CHARACTER IN BUSINESS ETHICS</title>
      <volume>8</volume>
      <issue>3</issue>
      <creator>Edwin M. Hartman</creator>
      <document_type>
        <snippet rank="1" score="100">
          <hit>
            <term>Article</term>
          </hit>
        </snippet>
      </document_type>
      <display-kind>dynaXML/TEI</display-kind>
      <sort-title>the role of character in business ethics</sort-title>
      <sort-creator>hartman</sort-creator>
    </meta>
    <snippet rank="1" score="100" sectionType="head ">Character and the <hit><term>Good</term></hit> Life</snippet>
    <snippet rank="2" score="21">this inclination at least by seeing to it that <hit><term>good</term></hit> corporate citizenship does not put the employee</snippet>
    <snippet rank="3" score="20">extent to which behavior that in the aggregate is <hit><term>bad</term></hit> for society is required for the survival of</snippet>
  </docHit>
</crossQueryResult>
END
