# frozen_string_literal: true

require "spec_helper"

RSpec.describe Kettle::Soup::Cover::Version do
  it_behaves_like "a Version module", described_class
end
