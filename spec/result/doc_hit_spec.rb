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

RSpec.describe "XTFDocHit" do
  describe "XTFDocHit#pages" do
    it "should be empty string if 'first_page' and 'last_page' are empty" do

    end
  end

  describe "XTFDocHit#query_with_all_snippets" do
    it "should replace maxSnippets value with '-1'" do
      @hit = XTF::Result::Element::DocHit.new(XML_DOC_HIT)
      @hit.instance_variable_set(:@query, %Q{<query style="style/crossQuery/resultFormatter/default/resultFormatter.xsl" startDoc="1" maxDocs="50" indexPath="index"><and maxSnippets="3"><term field="text">good</term></query>})
      expect(@hit.query_with_all_snippets).to eq %Q{<query style="style/crossQuery/resultFormatter/default/resultFormatter.xsl" startDoc="1" maxDocs="50" indexPath="index"><and maxSnippets="-1"><term field="text">good</term></query>}
    end
  end

  describe XTF::Result::Element::DocHit do
    before(:each) do
    end

    it "should parse the xml correctly" do
      @hit = XTF::Result::Element::DocHit.new(XML_DOC_HIT)

      expect(@hit.rank).to eq "1"
      expect(@hit.raw_path).to eq "default:beq/15-4/beq.div.15.4.66.xml"
      expect(@hit.path).to eq @hit.raw_path
      expect(@hit.score).to eq "100"
      expect(@hit.total_hits).to eq "104"

      expect(@hit.raw_snippets.size).to eq 3
      expect(@hit.raw_snippets[0]).to eq XML::Document.parse_string('<snippet rank="1" score="100" sectionType="head ">Case 4: The <hit><term>Good</term></hit> Bigot</snippet>').root.to_s
      expect(@hit.raw_snippets[1]).to eq XML::Document.parse_string('<snippet rank="2" score="21">with excellence, focusing on those internal <hit><term>goods</term></hit> thereby obtainable, while warding off threats</snippet>').root.to_s
      expect(@hit.raw_snippets[2]).to eq XML::Document.parse_string('<snippet rank="3" score="21">its own inordinate pursuit of external <hit><term>goods</term></hit> and from the corrupting power of other institutions</snippet>').root.to_s
    end
  end
end


QUERY =<<END
<query style="style/crossQuery/resultFormatter/default/resultFormatter.xsl" indexPath="index" startDoc="1" maxDocs="50">
  <or maxSnippets="3">
    <and field="text">
      <term>good</term>
      <term>bad</term>
    </and>
    <not field="document-type">
      <term>Journal</term>
    </not>
  </or>
</query>
END
XML_DOC_HIT =<<END
<docHit rank="1" path="default:beq/15-4/beq.div.15.4.66.xml" score="100" totalHits="104">
  <meta>
    <chunk-id>beq.div.15.4.66</chunk-id>
    <title>Corporate Character: Modern Virtue Ethics and The Virtuous Corporation</title>
    <volume>15</volume>
    <issue>4</issue>
    <creator>Geoff Moore</creator>
    <document-type>
      <snippet rank="1" score="100">
        <hit>
          <term>Article</term>
        </hit>
      </snippet>
    </document-type>
    <first-page>123</first-page>
    <last-page>130</last-page>
    <page>123</page>
    <page>124</page>
    <page>125</page>
    <page>126</page>
    <page>127</page>
    <page>128</page>
    <page>129</page>
    <page>130</page>
    <display-kind>dynaXML/TEI</display-kind>
    <sort-title>corporate character modern virtue ethics and the virtuous corporation</sort-title>
    <sort-creator>moore</sort-creator>
  </meta>
  <snippet rank="1" score="100" sectionType="head ">Case 4: The <hit><term>Good</term></hit> Bigot</snippet>
  <snippet rank="2" score="21">with excellence, focusing on those internal <hit><term>goods</term></hit> thereby obtainable, while warding off threats</snippet>
  <snippet rank="3" score="21">its own inordinate pursuit of external <hit><term>goods</term></hit> and from the corrupting power of other institutions</snippet>
</docHit>
END

XML_DOC_HIT_2_AUTHORS =<<END
<docHit rank="1" path="default:beq/15-4/beq.div.15.4.99.xml" score="100" totalHits="5">
  <meta>
    <chunk-id>beq.div.15.4.99</chunk-id>
    <title>Corporate Character: Modern Virtue Ethics and The Virtuous Corporation</title>
    <volume>15</volume>
    <issue>4</issue>
    <creator>George Leaman</creator>
    <creator>Mark Rooks</creator>
    <document-type>
      <snippet rank="1" score="100">
        <hit>
          <term>Article</term>
        </hit>
      </snippet>
    </document-type>
    <display-kind>dynaXML/TEI</display-kind>
    <sort-title>corporate character modern virtue ethics and the virtuous corporation</sort-title>
    <sort-creator>moore</sort-creator>
  </meta>
</docHit>
END

XML_DOC_HIT_3_AUTHORS =<<END
<docHit rank="1" path="default:beq/15-4/beq.div.15.4.3.xml" score="100" totalHits="5">
  <meta>
    <chunk-id>beq.div.15.4.3</chunk-id>
    <title>Corporate Character: Modern Virtue Ethics and The Virtuous Corporation</title>
    <volume>15</volume>
    <issue>4</issue>
    <creator>George Leaman</creator>
    <creator>Mark Rooks</creator>
    <creator>Matt Stephens</creator>
    <document-type>
      <snippet rank="1" score="100">
        <hit>
          <term>Article</term>
        </hit>
      </snippet>
    </document-type>
    <display-kind>dynaXML/TEI</display-kind>
    <sort-title>corporate character modern virtue ethics and the virtuous corporation</sort-title>
    <sort-creator>moore</sort-creator>
  </meta>
</docHit>
END

XML_DOC_HIT_LEADING_COLON =<<END
<docHit rank="1" path="default:beq/15-4/beq.div.15.4.3.xml" score="100" totalHits="5">
  <meta>
    <chunk-id>beq.div.15.4.3</chunk-id>
    <title>: Leading Colon Title</title>
    <document-type>Article</document-type>
    <display-kind>dynaXML/TEI</display-kind>
    <sort-title>leading colon title</sort-title>
  </meta>
</docHit>
END

XML_DOC_HIT_FIRST_WORD_IS_A =<<END
<docHit rank="1" path="default:beq/15-4/beq.div.15.4.3.xml" score="100" totalHits="5">
  <meta>
    <chunk-id>beq.div.15.4.3</chunk-id>
    <title>A At Start of Title</title>
    <document-type>Article</document-type>
    <display-kind>dynaXML/TEI</display-kind>
    <sort-title>a at start of title</sort-title>
  </meta>
</docHit>
END

XML_DOC_HIT_LAST_CHAR_IS_QUESTION_MARK =<<END
<docHit rank="1" path="default:beq/15-4/beq.div.15.4.3.xml" score="100" totalHits="5">
  <meta>
    <chunk-id>beq.div.15.4.3</chunk-id>
    <title>Last Character is Question Mark Preceded by a Space ?</title>
    <document-type>Article</document-type>
    <display-kind>dynaXML/TEI</display-kind>
    <sort-title>last character is question mark preceded by a space ?</sort-title>
  </meta>
</docHit>
END

XML_DOC_HIT_FIRST_CHAR_IS_QUESTION_MARK =<<END
<docHit rank="1" path="default:beq/15-4/beq.div.15.4.3.xml" score="100" totalHits="5">
  <meta>
    <chunk-id>beq.div.15.4.3</chunk-id>
    <title>? First Character is Question Mark Followed by a Space</title>
    <document-type>Article</document-type>
    <display-kind>dynaXML/TEI</display-kind>
    <sort-title>? first character is question mark followed by a space</sort-title>
  </meta>
</docHit>
END

XML_DOC_HIT_UNKNOWN_DOCUMENT_TYPE =<<END
<docHit rank="1" path="default:mls/15-4/mls.div.1.2.3.xml" score="100" totalHits="1">
  <meta>
    <chunk-id>mls.div.1.2.3</chunk-id>
    <title>Some Made Up Title</title>
    <volume>1</volume>
    <issue>2</issue>
    <creator>Jamie Orchard-Hays</creator>
    <document-type>
      <snippet rank="1" score="100">
        <hit>
          <term>some doc type</term>
        </hit>
      </snippet>
    </document-type>
    <display-kind>dynaXML/TEI</display-kind>
    <sort-title>some made up title</sort-title>
    <sort-creator>orchard-hays</sort-creator>
  </meta>
</docHit>
END

HIT =<<END
<docHit rank="1" path="default:jpr/17-0/jpr.div.17..118.xml" score="100"
        totalHits="175">
   <meta>
      <chunk-id>jpr.div.17..118</chunk-id>
      <title>

         <snippet rank="1" score="100">THE RELATION OF MORAL WORTH TO THE <hit>
               <term>GOOD</term>
            </hit> WILL IN KANT’S ETHICS</snippet>
      </title>
      <journal-title>Journal of Philosophical Research</journal-title>
      <journal-issue-title/>

      <facet-journal-title>Journal of Philosophical Research</facet-journal-title>
      <sort-journal-title>journal of philosophical research</sort-journal-title>
      <volume>17</volume>
      <issue>0</issue>
      <issn>1053-8364</issn>
      <section-heading>Articles</section-heading>

      <facet-section-heading>Articles</facet-section-heading>
      <sort-section-heading>Articles</sort-section-heading>
      <creator>WALTER E. SCHALLER</creator>
      <date>1992</date>
      <document-type>article</document-type>
      <first-page>351</first-page>

      <sort-first-page>351</sort-first-page>
      <last-page>382</last-page>
      <abstract>Abstract: I consider <snippet rank="1" score="100">three questions concerning the relation of the <hit>
               <term>good</term>
            </hit> will to the moral worth</snippet>
         <snippet rank="2" score="100">of actions. (1) Does a <hit>

               <term>good</term>
            </hit> will consist simply in acting from the motive of</snippet> duty? (2) Does acting from the motive <snippet rank="3" score="100">of duty presuppose that one has a <hit>
               <term>good</term>
            </hit> will? (3) Does the fact that one has a</snippet> good will entail that all of one’s duty-fulfilling actions have moral worth, even if they are not (directly) motivated by duty? I argue that while only persons with a good will are capable of acting from the motive of duty, it does not follow either that a good will consists in acting from duty or that if one has a good will, all of one’s dutiful actions will be motivated by duty. Whereas the good will is constituted by the agent’s highest-order maxim (the moral law itself), moral worth is a function of the agent’s firstorder maxims.</abstract>

      <publisher>Philosophy Documentation Center</publisher>
      <publisher-location>Charlottesville, Virginia, USA</publisher-location>
      <page>351</page>
      <page>352</page>
      <page>353</page>
      <page>354</page>

      <page>355</page>
      <page>356</page>
      <page>357</page>
      <page>358</page>
      <page>359</page>
      <page>360</page>

      <page>361</page>
      <page>362</page>
      <page>363</page>
      <page>364</page>
      <page>365</page>
      <page>366</page>

      <page>367</page>
      <page>368</page>
      <page>369</page>
      <page>370</page>
      <page>371</page>
      <page>372</page>

      <page>373</page>
      <page>374</page>
      <page>375</page>
      <page>376</page>
      <page>377</page>
      <page>378</page>

      <page>379</page>
      <page>380</page>
      <page>381</page>
      <page>382</page>
      <display-kind>dynaXML/TEI</display-kind>
      <year>1992</year>

      <sort-title>relation of moral worth to the good will in kants ethics</sort-title>
      <sort-journal-title>journal of philosophical research</sort-journal-title>
      <sort-creator>schaller</sort-creator>
      <sort-year>1992</sort-year>
      <sort-volume>017</sort-volume>
      <sort-issue>000</sort-issue>

      <facet-document-type>article</facet-document-type>
      <facet-title>THE RELATION OF MORAL WORTH TO THE GOOD WILL IN KANT’S ETHICS</facet-title>
      <facet-journal-title>Journal of Philosophical Research</facet-journal-title>
      <facet-creator>WALTER E. SCHALLER</facet-creator>
      <facet-year>1992</facet-year>
   </meta>

   <snippet rank="1" score="100" sectionType="head ">A. The Goodness of the <hit>
         <term>Good</term>
      </hit> Will</snippet>
   <snippet rank="2" score="83" sectionType="head ">V. Must a <hit>
         <term>Good</term>
      </hit> Will Be Indomitable?</snippet>

   <snippet rank="3" score="67" sectionType="head ">II. Does Acting from the Motive of Duty Presuppose a <hit>
         <term>Good</term>
      </hit> Will?</snippet>
</docHit>
END
