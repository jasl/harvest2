# frozen_string_literal: true

require "concurrent/hash"

class DynamicModelsCluster
  attr_reader :models

  def initialize
    @models = Concurrent::Hash.new
  end

  def [](key)
    models[key]
  end

  def []=(key, model)
    models[key] = model
  end

  def fetch_model_by_table(table)
    models.fetch(table.key)
  end

  def fetch_model_by_key(key)
    models.fetch(key)
  end

  def self.build_for(project)
    cluster = new

    tables = project.tables.includes(:columns, :has_many_relationships)

    tables.each do |table|
      cluster[table.key] = DynamicRecord.derive(table)
    end

    tables.each do |table|
      model = cluster[table.key]

      table.columns.each do |column|
        column.on_building_ar_model(model)
      end

      table.has_many_relationships.each do |relationship|
        next unless relationship.configured?

        foreign_table = tables.find { |t| t.id == relationship.foreign_table_id }
        foreign_column = foreign_table.columns.find { |c| c.id == relationship.foreign_column_id }
        foreign_model = cluster.fetch_model_by_table foreign_table

        model.has_many relationship.association_name.to_sym,
                       anonymous_class: foreign_model,
                       foreign_key: foreign_column.key,
                       dependent: :restrict_with_error

        foreign_model.belongs_to relationship.foreign_association_name.to_sym,
                                 anonymous_class: model,
                                 foreign_key: foreign_column.key,
                                 optional: !foreign_column.not_null?
      end
    end

    cluster
  end
end
