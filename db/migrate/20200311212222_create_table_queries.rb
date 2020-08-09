class CreateTableQueries < ActiveRecord::Migration[6.1]
  def change
    create_table :table_queries do |t|
      t.references :project, foreign_key: true, null: false
      t.references :table, foreign_key: true, null: false

      t.string :key, null: false
      t.index %i[project_id key], unique: true

      t.string :name

      t.boolean :protected, null: false, default: false
      t.boolean :system, null: false, default: false

      t.timestamps
    end
  end
end
