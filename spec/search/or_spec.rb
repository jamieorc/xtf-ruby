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

RSpec.describe "Or" do
  before(:each) do
    @or = Or.new()
  end
  it "should have attribute_keys: :field, :fields, :max_snippets, :boost, :slop" do
    expect(@or.attribute_keys).to eq XTF::Search::Element::Base::BASE_ATTRIBUTE_KEYS + [:fields, :slop]
  end

  it "should have an Array for content()" do
    expect(@or.content).to be_a(Array)
  end
end

RSpec.describe "Or.new" do
  it "should accept :field or :fields, but not both. Raise an error if both provided" do
    expect { Or.new(:field => "field") }.not_to raise_error
    expect { Or.new(:fields => "one, two", :slop => "8") }.not_to raise_error
    expect { Or.new(:field => "field", :fields => "one, two", :slop => "8") }.to raise_error(ArgumentError)
  end

  it "should require :slop attribute if :fields is provided, or vice-versa" do
    expect { Or.new(:fields => "one, two") }.to raise_error(ArgumentError)
    expect { Or.new(:slop => "8") }.to raise_error(ArgumentError)
    expect { Or.new(:fields => "one, two", :slop => "8") }.not_to raise_error
  end

end
