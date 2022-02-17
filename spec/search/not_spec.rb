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
