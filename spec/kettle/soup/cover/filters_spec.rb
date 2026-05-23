# frozen_string_literal: true

require "kettle/soup/cover/filters/gt_line_filter"
require "kettle/soup/cover/filters/lt_line_filter"

# rubocop:disable RSpec/DescribeClass
RSpec.describe "coverage line count filters" do
  let(:source_file) { instance_double(SimpleCov::SourceFile, lines: lines) }

  describe Kettle::Soup::Cover::Filters::GtLineFilter do
    subject(:matches?) { described_class.new(2).matches?(source_file) }

    let(:lines) { %w[a b c] }

    it { is_expected.to be(true) }
  end

  describe Kettle::Soup::Cover::Filters::LtLineFilter do
    subject(:matches?) { described_class.new(4).matches?(source_file) }

    let(:lines) { %w[a b c] }

    it { is_expected.to be(true) }
  end
end
# rubocop:enable RSpec/DescribeClass
