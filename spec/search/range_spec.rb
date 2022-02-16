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

RSpec.describe Range do
  it "should have 'tag_name' of 'range'" do
    @range = XTF::Search::Element::Range.new(1,2)
    expect(@range.tag_name).to eq "range"
  end
end

RSpec.describe "Range.new" do
  it "should raise an error if no arguments are provided" do
    expect { @range = XTF::Search::Element::Range.new }.to raise_error(ArgumentError)
  end
  it "should accept lower as first and upper as second arguments" do
    expect { @range = XTF::Search::Element::Range.new(1,2) }.not_to raise_error
  end

  it "should raise an error if only one argument or one argument before Hash argument is passed" do
    expect { @range = XTF::Search::Element::Range.new(1) }.to raise_error(ArgumentError)
    expect { @range = XTF::Search::Element::Range.new(1, :boost => 2) }.to raise_error(ArgumentError)
  end

  it "should accept lower and upper as part of attributes Hash" do
    expect { @range = XTF::Search::Element::Range.new(:lower => 1, :upper => 2) }.not_to raise_error
  end

  it "should raise an error if one of lower/upper pair is passed as argument and the other is passed as Hash member" do
    expect { @range = XTF::Search::Element::Range.new(1, :upper => 2) }.to raise_error(ArgumentError)
  end

  it "should accept lower and upper as integers or Strings and convert them to Strings" do
    expect { @range = XTF::Search::Element::Range.new(1, 2) }.not_to raise_error
    expect(@range.lower).to be_a(String)
    expect(@range.upper).to be_a(String)
    expect { @range = XTF::Search::Element::Range.new("1", "2") }.not_to raise_error
    expect { @range = XTF::Search::Element::Range.new(:lower => 1, :upper => 2) }.not_to raise_error
    expect(@range.lower).to be_a(String)
    expect(@range.upper).to be_a(String)
    expect { @range = XTF::Search::Element::Range.new(:lower => "1", :upper => "2") }.not_to raise_error
  end

  it "should output proper xml" do
    @range = XTF::Search::Element::Range.new(:lower => "1", :upper => "2", :inclusive => "yes", :numeric => "yes")
    result = @range.to_xml
    expect(result).to match(/^<range[^>]+inclusive="yes"/)
    expect(result).to match(/^<range[^>]+numeric="yes"/)
    expect(result).to include("<lower>1</lower>")
    expect(result).to include("<upper>2</upper>")
    expect(result).to include("</range>")
  end
end
