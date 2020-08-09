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
      find_by type: "BuiltinColumns::PrimaryKey"
    end
  end

  has_many :queries, class_name: "TableQuery",
           dependent: :destroy

  belongs_to :thumbnail_column,
             class_name: "Column",
             optional: true

  validates :key,
            presence: true,
            uniqueness: { scope: :project },
            exclusion: {
              in: Constants::RESERVED_KEYS
            }
  validates :key,
            format: { with: Constants::KEY_REGEX },
            unless: :system?

  validates :name,
            presence: true

  attr_readonly :key, :project_id

  before_create :build_builtin_columns

  # default_value_for :key,
  #                   ->(_) { "table_#{SecureRandom.hex(3)}" },
  #                   allow_nil: false

  include Helpers
  include Postgres
  include Faker
  include DynamicModel

  def thumbnail_column
    if thumbnail_column_id.present?
      if columns.loaded?
        columns.find { |c| c.id == thumbnail_column_id }
      else
        super
      end
    else
      if columns.loaded?
        columns.find { |c| c.type == "BuiltinColumns::PrimaryKey" }
      else
        columns.find_primary_key_column
      end
    end
  end

  private

    def build_builtin_columns
      columns.build key: BUILTIN_ID_COLUMN_KEY, type: "BuiltinColumns::PrimaryKey", not_null: false, unique: false,
                    position: 1, system: true, protected: true, name: I18n.t("defaults.column.builtin_names.id"),
                    project: project
      columns.build key: BUILTIN_CREATED_AT_COLUMN_KEY, type: "BuiltinColumns::Datetime", not_null: false, unique: false,
                    position: 2, system: true, protected: true, name: I18n.t("defaults.column.builtin_names.created_at"),
                    project: project
      columns.build key: BUILTIN_UPDATED_AT_COLUMN_KEY, type: "BuiltinColumns::Datetime", not_null: false, unique: false,
                    position: 3, system: true, protected: true, name: I18n.t("defaults.column.builtin_names.updated_at"),
                    project: project
    end
end
