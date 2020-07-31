# frozen_string_literal: true

module ColumnFilterQueriable
  module Scalar
    extend ActiveSupport::Concern

    # %w[
    #   column_key
    #   value_is_null? value_is_not_null?
    #   value_eq? value_not_eq?
    #   value_cont? value_not_cont?
    #   value_start_with? value_end_with?
    #
    #   eq_value eq_value_key
    #   not_eq_value not_eq_value_key
    #   gt_value gt_value_key
    #   gteq_value gteq_value_key
    #   lt_value lt_value_key
    #   lteq_value lteq_value_key
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
      if value_gt? && gt_value
        query = query.where("#{::ApplicationRecord.connection.quote_column_name(column_key)} > ?", gt_value)
      end
      if value_gteq? && gteq_value
        query = query.where("#{::ApplicationRecord.connection.quote_column_name(column_key)} >= ?", gteq_value)
      end
      if value_lt? && lt_value
        query = query.where("#{::ApplicationRecord.connection.quote_column_name(column_key)} < ?", lt_value)
      end
      if value_lteq? && lteq_value
        query = query.where("#{::ApplicationRecord.connection.quote_column_name(column_key)} <= ?", lteq_value)
      end

      query
    end
  end
end
