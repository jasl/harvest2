# frozen_string_literal: true

class ColumnFilterCondition < ApplicationRecord
  belongs_to :project
  belongs_to :table
  belongs_to :table_query

  belongs_to :filter_group, class_name: "ColumnFilterGroup"
  belongs_to :column

  serialize :configuration, SerializableModel::Base

  validate :validate_column_table, if: :new_record?
  validate :validate_configuration

  before_validation :set_redundancies, if: :new_record?

  attr_readonly :project_id, :table_id, :table_query_id, :column_id

  def apply_to(_query)
    raise NotImplementedError
  end

  def self.type_key
    model_name.name.demodulize.underscore.to_sym
  end

  def type_key
    self.class.type_key
  end

  private

    def validate_column_table
      return unless table_query && column

      unless column.table_id == table_query.table_id
        errors.add :column, :equal_to, count: table_query.table_id
      end
    end

    def validate_configuration
      return unless configuration
      unless configuration.valid?
        errors.add :options, :invalid
      end
    end

    def set_redundancies
      self.project = filter_group&.project
      self.table = filter_group&.table
      self.table_query = filter_group&.table_query
    end
end
