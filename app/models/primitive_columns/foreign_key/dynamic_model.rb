# frozen_string_literal: true

class PrimitiveColumns::ForeignKey
  module DynamicModel
    extend ActiveSupport::Concern

    def render_display_value(record, view_context: nil)
      target = record.send(relationship.foreign_association_name)
      relationship.table.thumbnail_column.render_display_value(target, view_context: view_context)
    end
  end
end
