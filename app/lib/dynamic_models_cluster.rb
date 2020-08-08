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

    tables = project.tables.includes(:columns)

    tables.each do |table|
      cluster[table.key] = DynamicRecord.derive(table)
    end

    tables.each do |table|
      model = cluster[table.key]
      table.columns.each do |column|
        column.on_building_ar_model(model)
      end
    end

    cluster
  end
end
