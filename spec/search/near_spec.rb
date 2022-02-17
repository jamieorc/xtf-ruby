require "spec_helper"

include XTF::Search::Element

RSpec.describe "Near" do
  before(:each) do
    @near = Near.new("8")
  end
  it "should have attribute_keys: :field, :max_snippets, :boost, :slop" do
    expect(@near.attribute_keys).to eq XTF::Search::Element::Base::BASE_ATTRIBUTE_KEYS + [:slop]
  end

  it "should have an Array for content()" do
    expect(@near.content).to be_a(Array)
  end
end

RSpec.describe "Near.new" do
  it "should raise an error if no slop provided" do
    expect { Near.new(:slop => "8") }.not_to raise_error
    expect { Near.new("8") }.not_to raise_error()
    expect { Near.new() }.to raise_error(ArgumentError)
  end

end
