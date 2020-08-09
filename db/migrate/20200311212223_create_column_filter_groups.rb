class CreateColumnFilterGroups < ActiveRecord::Migration[6.1]
  def change
    create_table :column_filter_groups do |t|
      t.references :project, foreign_key: true, null: false
      t.references :table, foreign_key: true, null: false

      t.references :table_query, foreign_key: true, null: false

      t.string :matcher, null: false, default: "and"

      t.timestamps
    end
  end
end
