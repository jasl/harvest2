# frozen_string_literal: true

class ColumnFilterGroup < ApplicationRecord
  # self.strict_loading_by_default = true

  belongs_to :project
  belongs_to :table

  belongs_to :table_query

  has_many :conditions, class_name: "ColumnFilterCondition",
           foreign_key: "filter_group_id", inverse_of: :filter_group,
           dependent: :delete_all, validate: true, autosave: true
  accepts_nested_attributes_for :conditions,
                                allow_destroy: true,
                                reject_if: proc { |attributes| attributes["column_id"].blank? || attributes["type"].blank? }

  enum matcher: {
    and: "and",
    or: "or"
  }, _prefix: :match

  before_validation :set_redundancies, if: :new_record?
  before_validation :preload_conditions_columns

  attr_readonly :project_id, :table_id, :table_query_id

  default_value_for :matcher, "and", allow_nil: false

  def apply_to(query)
    preload_conditions_columns

    case matcher
    when "and"
      conditions.each do |condition|
        query = condition.apply_to(query)
      end
    when "or"
      raw_query = query
      query = conditions[0].apply_to(raw_query)
      conditions[1..].each do |condition|
        query = query.or(condition.apply_to(raw_query))
      end
    else
      raise NotImplementedError
    end

    query
  end

  private

    def set_redundancies
      self.project = table_query&.project
      self.table = table_query&.table
    end

    # AR `includes` doesn't handle new records, this will help to prevent N+1
    def preload_conditions_columns
      ActiveRecord::Associations::Preloader.new.preload(conditions, :column)
    end
end
