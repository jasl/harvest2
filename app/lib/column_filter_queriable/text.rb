# frozen_string_literal: true

module ColumnFilterQueriable
  module Text
    extend ActiveSupport::Concern

    # %w[
    #   column_key
    #   value_is_null? value_is_not_null?
    #   value_eq? value_not_eq?
    #   value_cont? value_not_cont?
    #   value_start_with? value_end_with?
    # ].each do |name|
    #   class_eval <<-CODE, __FILE__, __LINE__ + 1
    #     def #{name}
    #       raise NotImplementedError, "`#{name}` not implemented yet."
    #     end
    #   CODE
    # end

    def apply_to(query, context: nil)
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
      if value_cont? && cont_value.present?
        query = query.where(
          "#{::ApplicationRecord.connection.quote_column_name(column_key)} LIKE %?%",
          cont_value
        )
      end
      if value_not_cont? & not_cont_value.present?
        query = query.where(
          "#{::ApplicationRecord.connection.quote_column_name(column_key)} NOT LIKE %?%",
          not_cont_value
        )
      end
      if value_start_with? && start_with_value.present?
        query = query.where(
          "#{::ApplicationRecord.connection.quote_column_name(column_key)} NOT LIKE %?",
          start_with_value
        )
      end
      if value_end_with? && end_with_value.present?
        query = query.where(
          "#{::ApplicationRecord.connection.quote_column_name(column_key)} NOT LIKE ?%",
          end_with_value
        )
      end

      query
    end
  end
end
