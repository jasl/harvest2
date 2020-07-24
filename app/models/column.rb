# frozen_string_literal: true

class Column < ApplicationRecord
  # self.strict_loading_by_default = true

  belongs_to :project, touch: true
  belongs_to :table, touch: true

  acts_as_list add_new_at: :bottom, top_of_list: 1

  serialize :display_options, ColumnOptions
  serialize :value_options, ColumnOptions
  serialize :validation_options, ColumnOptions
  serialize :storage_options, ColumnOptions

  after_initialize do
    self.display_options ||= ColumnOptions.new
    self.value_options ||= ColumnOptions.new
    self.validation_options ||= ColumnOptions.new
    self.storage_options ||= ColumnOptions.new
  end

  validates :key,
            presence: true,
            uniqueness: { scope: :table },
            exclusion: {
              in: Constants::RESERVED_KEYS
            }
  validates :key,
            format: { with: Constants::KEY_REGEX },
            unless: :builtin?

  validates :type,
            inclusion: {
              in: ->(_) { Column.descendants.map(&:to_s) }
            },
            allow_blank: false

  validates :name,
            presence: true

  attr_readonly :key, :project_id, :table_id, :type

  before_validation :auto_set_project_from_table

  # default_value_for :key,
  #                   ->(_) { "column_#{SecureRandom.hex(3)}" },
  #                   allow_nil: false

  def builtin?
    builtin || self.class.builtin?
  end

  def primitive_column?
    true
  end

  def symbolized_key
    key.to_sym
  end

  include Helpers
  include Postgres
  include Faker
  include DynamicModel

  class << self
    def builtin?
      false
    end

    def user_creatable?
      true
    end
  end

  protected

    def auto_set_project_from_table
      self.project = table&.project
    end
end
