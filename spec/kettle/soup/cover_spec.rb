# frozen_string_literal: true

RSpec.describe Kettle::Soup::Cover do
  it "has constant CI" do
    expect(described_class::CI).to be_a(String)
  end
end
