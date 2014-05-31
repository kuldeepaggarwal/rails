require 'cases/helper'

module ActiveRecord
  module ConnectionAdapters
    class NullColumnTest < ActiveRecord::TestCase
      def test_null_columns_are_identical_types
        column = ActiveRecord::ConnectionAdapters::NullColumn.new(:non_existing_column)
        test_object = Object.new

        assert_equal 'non_existing_column', column.name
        assert_equal nil, column.sql_type
        assert_equal nil, column.type
        assert_not column.number?
        assert_not column.text?
        assert_not column.binary?

        assert_equal test_object, column.type_cast(test_object)
        assert_equal test_object, column.type_cast_for_write(test_object)
        assert_equal test_object, column.type_cast_for_database(test_object)
      end
    end
  end
end
