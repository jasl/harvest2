# frozen_string_literal: true

class TableQuery < ApplicationRecord
  # self.strict_loading_by_default = true

  belongs_to :project
  belongs_to :table

  has_one :column_filter_group, dependent: :destroy,
          validate: true, autosave: true
  accepts_nested_attributes_for :column_filter_group,
                                allow_destroy: true

  validates :key,
            presence: true,
            uniqueness: { scope: :table },
            exclusion: {
              in: Constants::RESERVED_KEYS
            },
            unless: :one_time_usage
  validates :key,
            format: { with: Constants::KEY_REGEX },
            allow_blank: true,
            unless: :system?

  validates :name,
            presence: true,
            unless: :one_time_usage

  before_validation :set_redundancies, if: :new_record?

  after_initialize :build_column_filter_group, if: proc { |r| r.new_record? && !r.column_filter_group }

  attr_readonly :key, :project_id, :table_id

  default_value_for :key,
                    ->(_) { "table_query_#{SecureRandom.hex(3)}" },
                    allow_nil: false

  attr_accessor :one_time_usage

  def apply_to(query)
    column_filter_group.apply_to query
  end

  def to_query
    query = table_ar_model.all
    apply_to query
  end

  private

    def set_redundancies
      self.project = table&.project
    end

    def table_ar_model
      table.ar_model
    end
end
