require 'active_record/connection_adapters/column'

module ActiveRecord
  # :stopdoc:
  module ConnectionAdapters
    class NullColumn < Column
      def initialize(name)
        @name             = name.to_s
        @cast_type        = Type::Value.new
        @sql_type         = nil
        @null             = true
        @default          = nil
        @default_function = nil
      end
    end
  end
  # :startdoc:
end
