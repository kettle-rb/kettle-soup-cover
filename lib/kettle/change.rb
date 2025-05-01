module Kettle
  class Change < Module
    def initialize(constants: nil, path: nil)
      super()
      @constants = Array(constants) if constants
      @path = path if path
    end

    def included(base)
      constant_changer = ConstantChange.to_mod(constants: @constants, path: @path)
      base.send(:extend, constant_changer)
    end

    module ConstantChange
      class << self
        def to_mod(constants: nil, path: nil)
          Module.new do
            if constants && path
              define_method(:reset_const) do |*_args, &block|
                delete_const do
                  block&.call
                  load(path)
                end
              end

              define_method(:delete_const) do |*_args, &block|
                constants.each do |var|
                  remove_const(var) if defined?(var)
                end
                block&.call
                nil
              end
            end
          end
        end
      end
    end
  end
end
