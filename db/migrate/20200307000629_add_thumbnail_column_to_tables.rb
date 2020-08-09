class AddThumbnailColumnToTables < ActiveRecord::Migration[6.1]
  def change
    change_table :tables do |t|
      t.references :thumbnail_column, foreign_key: { to_table: :columns }
    end
  end
end
