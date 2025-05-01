# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kettle::Soup::Cover do
  include_context "with stubbed env"

  describe described_class::CONSTANTS do
    let(:values) {
      %w[
        CI
        COMMAND_NAME
        COVERAGE_DIR
        DEBUG
        DO_COV
        ENV_GET
        FALSE
        FILTER_DIRS
        FORMATTER_PLUGINS
        FORMATTERS
        IS_CI
        MERGE_TIMEOUT
        MIN_COVERAGE_BRANCH
        MIN_COVERAGE_LINE
        MIN_COVERAGE_HARD
        MULTI_FORMATTERS_DEFAULT
        MULTI_FORMATTERS
        PREFIX
        TRUE
        OPEN_BIN
        USE_MERGING
        VERBOSE
      ]
    }

    it "has values" do
      expect(described_class).to eq(values)
    end
  end

  describe "::reset_const" do
    subject(:reset_const) do
      described_class.reset_const do
        puts "CONSTANTS IS NOT DEFINED" unless defined?(Kettle::Soup::Cover::CONSTANTS)
      end
    end

    it "has output" do
      expect { reset_const }.to output("CONSTANTS IS NOT DEFINED\n").to_stdout
    end
  end

  describe "::load_filters" do
    subject(:load_filters) { described_class.load_filters }

    it "does not raise error" do
      block_is_expected.to not_raise_error
    end
  end

  context "when CI=true" do
    before do
      described_class.reset_const do
        stub_env("CI" => "true")
        stub_env("K_SOUP_COV_FORMATTERS" => nil)
      end
    end

    it "sets CI" do
      expect(described_class::CI).to eq("true")
    end

    it "sets IS_CI" do
      expect(described_class::IS_CI).to be(true)
    end

    it "sets FORMATTERS" do
      formatters = described_class::FORMATTERS.map { |x| x[:type] }
      expect(formatters).to eq(%i[html xml rcov lcov json tty])
    end

    it "sets MULTI_FORMATTERS_DEFAULT" do ||
      expect(described_class::MULTI_FORMATTERS_DEFAULT).to eq("true")
    end
  end

  context "when CI=false" do
    before do
      described_class.reset_const do
        stub_env("CI" => "false")
        stub_env("K_SOUP_COV_FORMATTERS" => nil)
      end
    end

    it "sets CI" do
      expect(described_class::CI).to eq("false")
    end

    it "sets IS_CI" do
      expect(described_class::IS_CI).to be(false)
    end

    it "sets FORMATTERS" do
      formatters = described_class::FORMATTERS.map { |x| x[:type] }
      expect(formatters).to eq(%i[html tty])
    end

    context "when K_SOUP_COV_MULTI_FORMATTERS not empty" do
      it "sets MULTI_FORMATTERS_DEFAULT" do ||
        expect(described_class::MULTI_FORMATTERS_DEFAULT).to eq("true")
      end
    end

    context "when K_SOUP_COV_MULTI_FORMATTERS empty" do
      before do
        described_class.reset_const do
          stub_env(
            "CI" => "false",
            "K_SOUP_COV_MULTI_FORMATTERS" => "",
          )
        end
      end

      it "sets MULTI_FORMATTERS_DEFAULT" do ||
        expect(described_class::MULTI_FORMATTERS_DEFAULT).to eq("true")
      end
    end

    context "when K_SOUP_COV_MULTI_FORMATTERS malformed with extra spaces" do
      before do
        described_class.reset_const do
          stub_env(
            "CI" => "false",
            "K_SOUP_COV_MULTI_FORMATTERS" => "true",
            "K_SOUP_COV_FORMATTERS" => "html, xml, rcov, lcov, json, tty",
          )
        end
      end

      it "sets MULTI_FORMATTERS_DEFAULT" do ||
        expect(described_class::MULTI_FORMATTERS_DEFAULT).to eq("true")
      end

      it "sets MULTI_FORMATTERS" do ||
        expect(described_class::MULTI_FORMATTERS).to be(true)
      end

      it "sets FORMATTERS" do ||
        expect(described_class::FORMATTERS).to eq(
          [
            {klass: "HTMLFormatter", lib: "simplecov-html", type: :html},
            {
              klass: "CoberturaFormatter",
              lib: "simplecov-cobertura",
              type: :xml,
            },
            {klass: "RcovFormatter", lib: "simplecov-rcov", type: :rcov},
            {klass: "LcovFormatter", lib: "simplecov-lcov", type: :lcov},
            {
              klass: "JSONFormatter",
              lib: "simplecov_json_formatter",
              type: :json,
            },
            {klass: "Console", lib: "simplecov-console", type: :tty},
          ],
        )
      end
    end
  end

  it "has constant COMMAND_NAME" do
    expect(described_class::COMMAND_NAME).to be_a(String)
  end

  it "has constant COVERAGE_DIR" do
    expect(described_class::COVERAGE_DIR).to be_a(String)
  end

  context "when debugging" do
    before do
      described_class.reset_const do
        stub_env("K_SOUP_COV_DEBUG" => "true")
      end
    end

    it "has constant DEBUG" do
      expect(described_class::DEBUG).to be(true)
    end
  end

  context "when not debugging" do
    before do
      described_class.reset_const do
        stub_env("K_SOUP_COV_DEBUG" => "false")
      end
    end

    it "has constant DEBUG" do
      expect(described_class::DEBUG).to be(false)
    end
  end

  context "when K_SOUP_COV_OPEN_BIN=''" do
    before do
      described_class.reset_const do
        stub_env("K_SOUP_COV_OPEN_BIN" => "")
      end
    end

    it "sets OPEN_BIN" do
      expect(described_class::OPEN_BIN).to eq("")
    end
  end

  context "when K_SOUP_COV_OPEN_BIN='xdg-open'" do
    before do
      described_class.reset_const do
        stub_env("K_SOUP_COV_OPEN_BIN" => "xdg-open")
      end
    end

    it "sets OPEN_BIN" do
      expect(described_class::OPEN_BIN).to eq("xdg-open")
    end
  end

  context "when K_SOUP_COV_OPEN_BIN is not set or nil" do
    context "when macOS" do
      before do
        described_class.reset_const do
          allow(RbConfig::CONFIG).to receive(:[]).with("host_os").and_return("darwin")
          stub_env("K_SOUP_COV_OPEN_BIN" => nil)
        end
      end

      it "sets OPEN_BIN according to RbConfig::Config['host_os']" do
        expect(described_class::OPEN_BIN).to eq("open")
      end
    end

    context "when not macOS" do
      before do
        described_class.reset_const do
          allow(RbConfig::CONFIG).to receive(:[]).with("host_os").and_return("banana")
          stub_env("K_SOUP_COV_OPEN_BIN" => nil)
        end
      end

      it "sets OPEN_BIN according to RbConfig::Config['host_os']" do
        expect(described_class::OPEN_BIN).to eq("xdg-open")
      end
    end
  end
end
