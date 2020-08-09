# frozen_string_literal: true

module ProjectsHelper
  def options_for_table_column_type(selected: nil)
    options_for_select(
      Columns.user_creatable_types.map { |klass| [klass.model_name.human, klass.to_s] },
      selected
    )
  end

  def options_for_table_relationship(project, selected: nil)
    options_for_select(
      project.tables.pluck(:name, :id),
      selected&.id
    )
  end

  def options_for_table_columns(table, selected: nil)
    options_for_select(
      table.columns.pluck(:name, :id),
      selected&.id
    )
  end
end
