# frozen_string_literal: true

module Relationships
  class BelongsTo < Relationship
    include Postgres

    def foreign_association_name
      customized = super
      if customized.present?
        customized
      else
        "#{table.key}_by_#{foreign_column.key}"
      end
    end

    def association_name
      customized = super
      if customized.present?
        customized
      else
        "#{foreign_table.key}_collection_of_#{column.key}"
      end
    end
  end
end
