# frozen_string_literal: true

class ReferenceColumn < Column
  def reference_column?
    true
  end

  has_one :relationship, class_name: "Relationships::BelongsTo",
          foreign_key: "foreign_column_id", inverse_of: :foreign_column,
          autosave: true, validate: true,
          dependent: :destroy

  accepts_nested_attributes_for :relationship

  after_initialize :auto_build_relationship, if: :new_record?

  validate do
    # If column key equal to table key, it will trouble on doing join query
    if relationship.table&.key == key
      errors.add :key, :exclusion
    end
  end

  include Postgres
  include Faker
  include DynamicModel

  def not_nullable?
    if new_record?
      !table_ar_model.exists?
    else
      table_ar_model.where(key => nil).size.zero?
    end
  end

  def uniqueable?
    new_record? || !table_ar_model.select(key).group(key).having("count(*) > 1").exists?
  end

  private

    def auto_build_relationship
      return if relationship

      build_relationship type: "Relationships::BelongsTo", foreign_table: table, project: project
    end
end
