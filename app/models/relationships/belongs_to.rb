# frozen_string_literal: true

module Relationships
  class BelongsTo < Relationship
    include Postgres

    attr_readonly :foreign_table_id, :foreign_column_id

    before_validation :set_association_names

    private

      def set_association_names
        if configured?
          self.association_name = "#{foreign_table.key}_collection_of_#{column.key}"
          self.foreign_association_name = "#{table.key}_by_#{foreign_column.key}"
        else
          self.association_name = nil
          self.foreign_association_name = nil
        end
      end
  end
end
