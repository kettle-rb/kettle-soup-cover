# frozen_string_literal: true

RSpec.describe Kettle::Soup::Cover::Constants do
  include_context "with stubbed env"

  before do
    described_class.reset_const do
      stub_env("CI" => ci)
    end
  end

  let(:ci) { "true" }

  it 'succeeds' do
    block_is_expected.to_not raise_error
  end

  context 'when CI=true' do
    it "sets CI=true" do
      expect(described_class::CI).to eq("true")
    end
  end

  context 'when CI=true' do
    let(:ci) { "false" }

    it "sets CI=false" do
      expect(described_class::CI).to eq("false")
    end
  end
end
