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

require "spec_helper"

include XTF::Search::Element

RSpec.describe "Phrase" do
  before(:each) do
    @phrase = Phrase.new()
  end
  it "should have attribute_keys: :field, :max_snippets, :boost" do
    expect(@phrase.attribute_keys).to eq XTF::Search::Element::Base::BASE_ATTRIBUTE_KEYS
  end

  it "should have an Array for content()" do
    expect(@phrase.content).to be_a(Array)
  end

  it "should take a :phrase attribute, tokenize it and create Terms" do
    @phrase = Phrase.new(:phrase => "this is a phrase")
    result = @phrase.to_xml
    expect(result).to include("<phrase>")
    expect(result).to include("<term>this</term>")
    expect(result).to include("<term>is</term>")
    expect(result).to include("<term>a</term>")
    expect(result).to include("<term>phrase</term>")
    expect(result).to include("</phrase>")
  end
end

RSpec.describe "Phrase#phrase=" do
  before(:each) do
    @phrase = Phrase.new()
  end
  it "should raise an ArgumentError unless argument is a String" do
    expect { @phrase.phrase = :something }.to raise_error(ArgumentError)
    expect { @phrase.phrase="some words" }.not_to raise_error

  end

  it "should take a String, tokenize it and create Terms" do
    @phrase.phrase = "this is a phrase"
    result = @phrase.to_xml
    expect(result).to include("<phrase>")
    expect(result).to include("<term>this</term>")
    expect(result).to include("<term>is</term>")
    expect(result).to include("<term>a</term>")
    expect(result).to include("<term>phrase</term>")
    expect(result).to include("</phrase>")
  end

  it "should move solitary wildcard to previous term" do
    @phrase.phrase="some words,*"
    expect(@phrase.to_xml).to match /<phrase>\s*<term>some<\/term>\s*<term>words\*<\/term>\s*<\/phrase>/
  end
end
