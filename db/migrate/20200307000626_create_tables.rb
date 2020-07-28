# frozen_string_literal: true

class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :tables do |t|
      t.references :project, foreign_key: true, null: false

      t.string :key, null: false
      t.index %i[project_id key], unique: true

      t.text :name
      t.text :description

      t.boolean :protected, null: false, default: false
      t.boolean :system, null: false, default: false

      t.timestamps
    end
  end
end
