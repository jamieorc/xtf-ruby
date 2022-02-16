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

RSpec.describe "Not" do
  before(:each) do
    @not = Not.new()
  end
  it "should have attribute_keys: :field, :max_snippets, :boost" do
    expect(@not.attribute_keys).to eq XTF::Search::Element::Base::BASE_ATTRIBUTE_KEYS
  end

  it "should have an Array for content()" do
    expect(@not.content).to be_a(Array)
  end
end
