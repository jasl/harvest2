# frozen_string_literal: true

class ReferenceColumn
  module DynamicModel
    extend ActiveSupport::Concern

    include PrimitiveColumn::DynamicModel

    def render_options_for_select(record, filter: nil, view_context:)
      target_table = relationship.table
      return [] unless target_table

      target_model = target_table.ar_model
      records = target_model.all
      records = filter.call(records) if filter

      target_id = record.send(relationship.foreign_association_name)&.id

      view_context.options_for_select(
        records.map { |r| [target_table.thumbnail_column.render_display_value(r, view_context: view_context), r.id] },
        target_id
      )
    end
  end
end
