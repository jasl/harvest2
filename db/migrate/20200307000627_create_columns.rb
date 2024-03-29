class CreateColumns < ActiveRecord::Migration[6.1]
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

      t.text :display_configuration
      t.text :value_configuration
      t.text :validation_configuration
      t.text :storage_configuration

      t.boolean :protected, null: false, default: false
      t.boolean :system, null: false, default: false

      t.string :type, null: false

      t.timestamps
    end
  end
end
