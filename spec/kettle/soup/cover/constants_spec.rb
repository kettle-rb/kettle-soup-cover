# frozen_string_literal: true

RSpec.describe Kettle::Soup::Cover::Constants do
  include_context "with stubbed env"
  include_context "with hidden env"

  describe "CI" do
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

  describe "MIN_COVERAGE_HARD" do
    before do
      described_class.reset_const do
        stub_env("CI" => ci)
        stub_env("K_SOUP_COV_MULTI_FORMATTERS" => "false")
        if min_hard.nil?
          hide_env("K_SOUP_COV_MIN_HARD")
        else
          stub_env("K_SOUP_COV_MIN_HARD" => min_hard)
        end
      end
    end

    let(:ci) { "true" }
    let(:min_hard) { nil } # nil means not set (use default)

    context "when CI=true and K_SOUP_COV_MIN_HARD is not set" do
      let(:ci) { "true" }
      let(:min_hard) { nil }

      it "defaults to true (CI behavior)" do
        expect(described_class::MIN_COVERAGE_HARD).to be(true)
      end
    end

    context "when CI=true and K_SOUP_COV_MIN_HARD=true" do
      let(:ci) { "true" }
      let(:min_hard) { "true" }

      it "is true" do
        expect(described_class::MIN_COVERAGE_HARD).to be(true)
      end
    end

    context "when CI=true and K_SOUP_COV_MIN_HARD=false" do
      let(:ci) { "true" }
      let(:min_hard) { "false" }

      it "is false (explicit override)" do
        expect(described_class::MIN_COVERAGE_HARD).to be(false)
      end
    end

    context "when CI=false and K_SOUP_COV_MIN_HARD is not set" do
      let(:ci) { "false" }
      let(:min_hard) { nil }

      it "defaults to false (non-CI behavior)" do
        expect(described_class::MIN_COVERAGE_HARD).to be(false)
      end
    end

    context "when CI=false and K_SOUP_COV_MIN_HARD=true" do
      let(:ci) { "false" }
      let(:min_hard) { "true" }

      it "is true (explicit override)" do
        expect(described_class::MIN_COVERAGE_HARD).to be(true)
      end
    end

    context "when CI=false and K_SOUP_COV_MIN_HARD=false" do
      let(:ci) { "false" }
      let(:min_hard) { "false" }

      it "is false" do
        expect(described_class::MIN_COVERAGE_HARD).to be(false)
      end
    end
  end
end
