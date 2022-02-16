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

RSpec.describe Base do
  before(:each) do
    @attributes = {:field => "name", :max_snippets => "6", :boost => "2"}
    @base = XTF::Search::Element::Base.new(@attributes)
  end

  it "should have 'BASE_ATTRIBUTE_KEYS' array with 'field', 'max_snippets', 'boost'" do
    expect(XTF::Search::Element::Base::BASE_ATTRIBUTE_KEYS.length).to eq 3
    expect(XTF::Search::Element::Base::BASE_ATTRIBUTE_KEYS).to eq [:field, :max_snippets, :boost]
  end

  it "should have 'attribute_keys' equal to BASE_ATTRIBUTE_KEYS" do
    expect(@base.attribute_keys).to eq XTF::Search::Element::Base::BASE_ATTRIBUTE_KEYS
  end

  it "'attributes' should return the attributes listed in BASE_ATTRIBUTE_KEYS in a Hash with their values" do
    expect(@base.attributes.size).to eq 3
    expect(@base.attributes).to eq @attributes
  end

  it "'attributes' should not include attributes will nil values" do
    @base.max_snippets = nil
    expect(@base.attributes.size).to eq 2
    @attributes.delete(:max_snippets)
    expect(@base.attributes).to eq @attributes
  end

  it "should take attributes as a Hash when instantiated and populate each property." do
    expect(@base.field).to eq @attributes[:field]
    expect(@base.max_snippets).to eq @attributes[:max_snippets]
    expect(@base.boost).to eq @attributes[:boost]
  end

  it "should silently ignore bogus attributes on instantiation" do
    attributes = @attributes.merge({:bogus_key => "bogus value"})
    @base = XTF::Search::Element::Base.new(attributes)
    expect(@base.attributes.size).to eq 3
    expect(@base.attributes).to eq @attributes
  end
end
