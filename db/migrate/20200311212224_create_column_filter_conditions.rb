class CreateColumnFilterConditions < ActiveRecord::Migration[6.0]
  def change
    create_table :column_filter_conditions do |t|
      t.references :project, foreign_key: true, null: false
      t.references :table, foreign_key: true, null: false
      t.references :table_query, foreign_key: true, null: false

      t.references :filter_group, foreign_key: { to_table: :column_filter_groups }, null: false
      t.references :column, foreign_key: true, null: false

      t.text :configuration

      t.string :type, null: false

      t.timestamps
    end
  end
end
