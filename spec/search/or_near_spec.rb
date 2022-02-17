require "spec_helper"

include XTF::Search::Element

RSpec.describe "OrNear" do
  before(:each) do
    @orNear = OrNear.new("8")
  end
  it "should have attribute_keys: :field, :max_snippets, :boost, :slop" do
    expect(@orNear.attribute_keys).to eq XTF::Search::Element::Base::BASE_ATTRIBUTE_KEYS + [:slop]
  end

  it "should have an Array for content()" do
    expect(@orNear.content).to be_a(Array)
  end
end

RSpec.describe "OrNear.new" do
  it "should raise an error if no slop provided" do
    expect { OrNear.new(:slop => "8") }.not_to raise_error
    expect { OrNear.new("8") }.not_to raise_error
    expect { OrNear.new() }.to raise_error(ArgumentError)
  end

end
