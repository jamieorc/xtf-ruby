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
