class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.references :project, foreign_key: true, null: false

      t.references :table, foreign_key: true
      t.references :column, foreign_key: { to_table: "columns" }
      t.references :foreign_table, foreign_key: { to_table: "tables" }
      t.references :foreign_column, foreign_key: { to_table: "columns" }

      t.string :association_name
      t.string :foreign_association_name

      t.index %i[column_id foreign_column_id], unique: true
      t.index %i[table_id association_name], unique: true,
              name: "index_relationships_on_table_association_name"
      t.index %i[foreign_table_id foreign_association_name], unique: true,
              name: "index_relationships_on_foreign_table_association_name"

      t.string :type, null: false

      t.timestamps
    end
  end
end
