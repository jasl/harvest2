# frozen_string_literal: true

class DynamicRecord < ActiveRecord::Base
  self.abstract_class = true
  self.inheritance_column = nil

  include ActsAsDefaultValue
  include EnumAttributeLocalizable

  class << self
    attr_accessor :table_id, :name, :model_name

    def derive(table)
      connection.schema_cache.clear_data_source_cache!(table.pg_table_name)

      klass = Class.new(self)

      klass.table_id = table.id
      klass.table_name = table.pg_table_name
      klass.name = "generated/project_#{table.project_id}/table_#{table.key}".classify
      klass.model_name = ActiveModel::Name.new(klass, false)

      klass.reset_column_information

      klass
    end

    def decorate_attribute(attr_name, coder = Object, validate: false)
      serialize attr_name, coder
      if validate
        validates_associated attr_name, if: attr_name
      end
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{attr_name}=(value)
          super #{coder}.load(value)
        end
      RUBY
    end
  end

  private

    def read_attribute_for_serialization(key)
      attr = send key
      attr.respond_to?(:serializable_hash) ? attr.serializable_hash : attr
    end
end
