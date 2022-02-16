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

RSpec.describe "AllDocs.new" do
  it "should take no arguments and raise error if any passed in" do
    expect { AllDocs.new }.not_to raise_error
    expect { AllDocs.new(value: "none") }.to raise_error(ArgumentError)
  end

  it "'to_xml' should only return '<allDocs/>" do
    expect(AllDocs.new.to_xml).to eq "<allDocs/>"
  end
end
