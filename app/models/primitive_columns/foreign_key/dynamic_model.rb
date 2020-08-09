# frozen_string_literal: true

class PrimitiveColumns::ForeignKey
  module DynamicModel
    extend ActiveSupport::Concern

    def render_value(record, view_context: nil)
      target = record.send(relationship.foreign_association_name)
      relationship.table.thumbnail_column.render_value(target, view_context: view_context)
    end
  end
end
