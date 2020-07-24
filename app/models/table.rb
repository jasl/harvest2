# frozen_string_literal: true

class Table < ApplicationRecord
  BUILTIN_ID_COLUMN_KEY = "id"
  BUILTIN_CREATED_AT_COLUMN_KEY = "created_at"
  BUILTIN_UPDATED_AT_COLUMN_KEY = "updated_at"

  belongs_to :project, touch: true

  has_many :has_many_relationships, class_name: "Relationship",
           foreign_key: "table_id",
           dependent: :destroy
  has_many :belongs_to_relationships, class_name: "Relationship",
           foreign_key: "foreign_table_id",
           dependent: :destroy

  has_many :columns, -> { order(position: :asc) },
           class_name: "Column", inverse_of: :table,
           dependent: :delete_all, validate: true, autosave: true do
    def find_primary_key_column
      find_by type: Columns::Builtins::PrimaryKey.to_s
    end
  end

  validates :key,
            presence: true,
            uniqueness: { scope: :project },
            exclusion: {
              in: Constants::RESERVED_KEYS
            }
  validates :key,
            format: { with: Constants::KEY_REGEX },
            unless: :builtin?

  validates :name,
            presence: true

  attr_readonly :key, :project_id

  before_create :build_builtin_columns

  # default_value_for :key,
  #                   ->(_) { "table_#{SecureRandom.hex(3)}" },
  #                   allow_nil: false

  include Postgres
  include Faker
  include DynamicModel

  def builtin?
    builtin || self.class.builtin?
  end

  class << self
    def builtin?
      false
    end
  end

  private

    def build_builtin_columns
      columns.build key: BUILTIN_ID_COLUMN_KEY, type: "Columns::Builtins::PrimaryKey", not_null: false, unique: false,
                    position: 1, builtin: true, name: I18n.t("defaults.column.builtin_names.id"),
                    project: project
      columns.build key: BUILTIN_CREATED_AT_COLUMN_KEY, type: "Columns::Builtins::Datetime", not_null: false, unique: false,
                    position: 3, builtin: true, name: I18n.t("defaults.column.builtin_names.created_at"),
                    project: project
      columns.build key: BUILTIN_UPDATED_AT_COLUMN_KEY, type: "Columns::Builtins::Datetime", not_null: false, unique: false,
                    position: 4, builtin: true, name: I18n.t("defaults.column.builtin_names.updated_at"),
                    project: project
    end
end
