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

RSpec.describe "Exact" do
  before(:each) do
    @exact = Exact.new()
  end
  it "should have attribute_keys: :field, :max_snippets, :boost" do
    expect(@exact.attribute_keys).to eq XTF::Search::Element::Base::BASE_ATTRIBUTE_KEYS
  end

  it "should have an Array for content()" do
    expect(@exact.content).to be_a(Array)
  end

  it "should take a :phrase attribute, tokenize it and create Terms" do
    @exact = Exact.new(:phrase => "this is a phrase")
    result = @exact.to_xml
    expect(result).to include("<exact>")
    expect(result).to include("<term>this</term>")
    expect(result).to include("<term>is</term>")
    expect(result).to include("<term>a</term>")
    expect(result).to include("<term>phrase</term>")
    expect(result).to include("</exact>")
  end
end

RSpec.describe "Exact#phrase=" do
  before(:each) do
    @exact = Exact.new()
  end
  it "should raise an ArgumentError unless argument is a String" do
    expect { @exact.phrase = :something }.to raise_error(ArgumentError)
    expect { @exact.phrase="some words" }.not_to raise_error

  end

  it "should take a String, tokenize it and create Terms" do
    @exact.phrase = "this is a phrase"
    result = @exact.to_xml
    expect(result).to include("<exact>")
    expect(result).to include("<term>this</term>")
    expect(result).to include("<term>is</term>")
    expect(result).to include("<term>a</term>")
    expect(result).to include("<term>phrase</term>")
    expect(result).to include("</exact>")
  end
end
