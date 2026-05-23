# frozen_string_literal: true

RSpec.describe Kettle::Change do
  describe "::new" do
    it "builds an inert module when no constants or path are provided" do
      base = Module.new

      base.include(described_class.new)

      expect(base).not_to respond_to(:reset_const)
      expect(base).not_to respond_to(:delete_const)
    end

    it "adds constant reset helpers when constants and path are provided" do
      base = Module.new

      base.include(described_class.new(constants: "EXAMPLE", path: "kettle/soup/cover/constants.rb"))

      expect(base).to respond_to(:reset_const)
      expect(base).to respond_to(:delete_const)
    end

    it "deletes configured constants without requiring a block" do
      base = Module.new
      base.const_set(:EXAMPLE, "value")
      base.include(described_class.new(constants: "EXAMPLE", path: "kettle/soup/cover/constants.rb"))

      base.delete_const

      expect(base.const_defined?(:EXAMPLE, false)).to be(false)
    end

    it "ignores missing configured constants" do
      base = Module.new
      base.include(described_class.new(constants: "EXAMPLE", path: "kettle/soup/cover/constants.rb"))

      expect { base.delete_const }.not_to raise_error
    end

    it "resets configured constants without requiring a block" do
      base = Module.new
      tmp_parent = File.expand_path("../../tmp", __dir__)
      FileUtils.mkdir_p(tmp_parent)
      tmp_dir = Dir.mktmpdir(nil, tmp_parent)
      path = File.join(tmp_dir, "constants.rb")
      stub_const("Kettle::ChangeSpecModule", base)
      File.write(path, "Kettle::ChangeSpecModule.const_set(:EXAMPLE, \"reset\")\n")
      base.include(described_class.new(constants: "EXAMPLE", path: path))

      expect { base.reset_const }.not_to raise_error
      expect(base.const_get(:EXAMPLE)).to eq("reset")
    ensure
      FileUtils.remove_entry(tmp_dir) if tmp_dir
    end
  end
end
