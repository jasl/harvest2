# frozen_string_literal: true

class Column < ApplicationRecord
  # self.strict_loading_by_default = true

  belongs_to :project, touch: true
  belongs_to :table, touch: true

  acts_as_list add_new_at: :bottom, top_of_list: 1

  serialize :display_configuration, ColumnConfiguration
  serialize :value_configuration, ColumnConfiguration
  serialize :validation_configuration, ColumnConfiguration
  serialize :storage_configuration, ColumnConfiguration

  after_initialize do
    self.display_configuration ||= ColumnConfiguration.new
    self.value_configuration ||= ColumnConfiguration.new
    self.validation_configuration ||= ColumnConfiguration.new
    self.storage_configuration ||= ColumnConfiguration.new
  end

  validates :key,
            presence: true,
            uniqueness: { scope: :table },
            exclusion: {
              in: Constants::RESERVED_KEYS
            }
  validates :key,
            format: { with: Constants::KEY_REGEX },
            unless: :system?

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

  def builtin_column?
    false
  end

  def primitive_column?
    false
  end

  def virtual_column?
    false
  end

  def symbolized_key
    key.to_sym
  end

  def type_key
    self.class.type_key
  end

  include Helpers
  include ColumnQuery
  include Faker
  include DynamicModel

  class << self
    def user_creatable?
      true
    end

    def type_key
      model_name.name.demodulize.underscore.to_sym
    end
  end

  private

    def auto_set_project_from_table
      self.project = table&.project
    end
end
