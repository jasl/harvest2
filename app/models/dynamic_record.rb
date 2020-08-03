# frozen_string_literal: true

class DynamicRecord < ActiveRecord::Base
  self.abstract_class = true
  self.inheritance_column = nil

  include ActsAsDefaultValue
  include EnumAttributeLocalizable

  class << self
    attr_accessor :table_id, :name

    def derive(table)
      klass = Class.new(self)

      klass.table_id = table.id
      klass.table_name = table.pg_table_name
      klass.name = "dynamic_generated_project_#{table.project_id}_#{table.key}".classify

      table.columns.each do |column|
        column.on_building_ar_model(klass)
      end

      klass.reset_column_information

      klass
    end
  end
end
