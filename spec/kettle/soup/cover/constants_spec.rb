# frozen_string_literal: true

RSpec.describe Kettle::Soup::Cover::Constants do
  include_context "with stubbed env"

  before do
    described_class.reset_const do
      stub_env("CI" => ci)
      stub_env("K_SOUP_COV_MULTI_FORMATTERS" => multi_formatters)
    end
  end

  let(:ci) { "true" }
  let(:multi_formatters) { "" }

  it "succeeds" do
    block_is_expected.not_to raise_error
  end

  context "when CI=true" do
    it "sets CI=true" do
      expect(described_class::CI).to eq("true")
    end
  end

  context "when CI=false" do
    let(:ci) { "false" }

    it "sets CI=false" do
      expect(described_class::CI).to eq("false")
    end

    it "sets MULTI_FORMATTERS" do
      expect(described_class::MULTI_FORMATTERS).to be(false)
    end
  end
end
