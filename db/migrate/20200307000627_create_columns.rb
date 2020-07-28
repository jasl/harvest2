# frozen_string_literal: true

class CreateColumns < ActiveRecord::Migration[6.0]
  def change
    create_table :columns do |t|
      t.references :project, foreign_key: true, null: false

      t.references :table, foreign_key: true, null: false

      t.string :key, null: false
      t.index %i[table_id key], unique: true

      t.text :name
      t.text :description
      t.integer :position

      t.boolean :not_null, null: false, default: false
      t.boolean :unique, null: false, default: false

      t.text :display_options
      t.text :value_options
      t.text :validation_options
      t.text :storage_options

      t.boolean :protected, null: false, default: false
      t.boolean :system, null: false, default: false

      t.string :type, null: false

      t.timestamps
    end
  end
end
