# frozen_string_literal: true

class ScalarColumnFilterCondition < ColumnFilterCondition
  def column_key
    column.key
  end

  def value_is_null?
    configuration.is_null?
  end

  def value_is_not_null?
    configuration.is_not_null?
  end

  private

    def self.generate_matcher_methods(*matchers)
      matchers.each do |name|
        class_eval <<-CODE, __FILE__, __LINE__ + 1
          def value_#{name}?
            configuration.#{name}?
          end

          def #{name}_value
            configuration.value
          end
        CODE
      end
    end
end
