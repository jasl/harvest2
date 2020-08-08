# frozen_string_literal: true

class Relationship < ApplicationRecord
  # self.strict_loading_by_default = true

  belongs_to :project, touch: true

  belongs_to :table, optional: true
  belongs_to :column, class_name: "Column", optional: true
  belongs_to :foreign_table, class_name: "Table"
  belongs_to :foreign_column, class_name: "Column"

  validates :type,
            presence: true

  validate :tables_must_be_the_same_project
  validates :column_id,
            uniqueness: { scope: :foreign_column },
            allow_blank: true

  validates :foreign_association_name,
            uniqueness: {
              scope: :foreign_table
            }, allow_blank: true
  validates :association_name,
            uniqueness: {
              scope: :table
            }, allow_blank: true

  before_validation :set_column_by_table
  before_validation :set_foreign_table_and_project

  after_update :invalidate_project_models_cluster

  def configured?
    table_id.present? && column_id.present? && foreign_table_id.present? && foreign_column_id.present?
  end

  private

    def set_column_by_table
      unless table
        self.column = nil
        return
      end

      if table_id_change || !column
        self.column = table.columns.find_primary_key_column
      end
    end

    def set_foreign_table_and_project
      if foreign_column.new_record? || (foreign_column_id_changed? && foreign_column)
        self.foreign_table = foreign_column.table
        self.project = foreign_table.project
      end
    end

    def tables_must_be_the_same_project
      if table && table.project_id != project&.id
        errors.add :table, :invalid
      end
    end

    def invalidate_project_models_cluster
      project.invalidate_project_models_cluster
    end
end
