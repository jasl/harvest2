# frozen_string_literal: true

module ColumnFilterQueriable
  module Boolean
    extend ActiveSupport::Concern

    # %w[
    #   column_key
    #   value_is_null? value_is_not_null?
    #   value_eq? value_not_eq?
    # ].each do |name|
    #   class_eval <<-CODE, __FILE__, __LINE__ + 1
    #     def #{name}
    #       raise NotImplementedError, "`#{name}` not implemented yet."
    #     end
    #   CODE
    # end

    def apply_to(query)
      if value_is_null?
        return query.where(column_key => nil)
      elsif value_is_not_null?
        return query.where.not(column_key => nil)
      end

      if value_eq?
        query = query.where(column_key => eq_value)
      end
      if value_not_eq?
        query = query.where.not(column_key => not_eq_value)
      end

      query
    end
  end
end
