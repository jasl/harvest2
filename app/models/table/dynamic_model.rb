# frozen_string_literal: true

class Table
  module DynamicModel
    extend ActiveSupport::Concern

    included do
      after_destroy :unload_cached_ar_model
    end

    def ar_model_cache_key
      "#{pg_table_name}.ar_model"
    end

    def unload_cached_ar_model
      Globals.table_ar_model_cache.delete ar_model_cache_key
      self.class.connection.schema_cache.clear_data_source_cache!(pg_table_name)
    end

    def to_ar_model(reload: false)
      unload_cached_ar_model if reload
      Globals.table_ar_model_cache.getset(ar_model_cache_key) do
        DynamicRecord.derive(self)
      end
    end

    def configure_ar_model(model, build_relationships: false)
      if build_relationships
        belongs_to_relationships.each do |relationship|
          ar_model = relationship.table.to_ar_model
          model.belongs_to relationship.foreign_association_name.to_sym, anonymous_class: ar_model, foreign_key: relationship.foreign_column.key, optional: true
        end

        has_many_relationships.each do |relationship|
          ar_model = relationship.foreign_table.to_ar_model
          model.has_many relationship.association_name.to_sym, anonymous_class: ar_model, foreign_key: relationship.foreign_column.key
        end
      end
    end
  end
end
