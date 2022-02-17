require "spec_helper"

include XTF::Search::Element

RSpec.describe "And" do
  before(:each) do
    @and = And.new()
  end
  it "should have attribute_keys: :field, :fields, :max_snippets, :boost, :use_proximity, :slop" do
    expect(@and.attribute_keys).to eq XTF::Search::Element::Base::BASE_ATTRIBUTE_KEYS + [:fields, :use_proximity, :slop]
  end

  it "should have an Array for content()" do
    expect(@and.content).to be_an Array
  end
end

RSpec.describe "And.new" do
  it "should accept :field or :fields, but not both. Raise an error if both provided" do
    expect { And.new(:field => "field") }.not_to raise_error
    expect { And.new(:fields => "one, two", :slop => "8") }.not_to raise_error
    expect { And.new(:field => "field", :fields => "one, two", :slop => "8") }.to raise_error(ArgumentError)
  end

  it "should require :slop attribute if :fields is provided, and vice-versa" do
    expect { And.new(:fields => "one, two") }.to raise_error(ArgumentError)
    expect { And.new(:slop => "8") }.to raise_error(ArgumentError)
    expect { And.new(:fields => "one, two", :slop => "8") }.not_to raise_error

    @clause = And.new(:fields => "one, two", :slop => "8", :max_snippets => "4")
  end

end
