# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_11_212224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "column_filter_conditions", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "table_id", null: false
    t.bigint "table_query_id", null: false
    t.bigint "filter_group_id", null: false
    t.bigint "column_id", null: false
    t.text "configuration"
    t.string "type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["column_id"], name: "index_column_filter_conditions_on_column_id"
    t.index ["filter_group_id"], name: "index_column_filter_conditions_on_filter_group_id"
    t.index ["project_id"], name: "index_column_filter_conditions_on_project_id"
    t.index ["table_id"], name: "index_column_filter_conditions_on_table_id"
    t.index ["table_query_id"], name: "index_column_filter_conditions_on_table_query_id"
  end

  create_table "column_filter_groups", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "table_id", null: false
    t.bigint "table_query_id", null: false
    t.string "matcher", default: "and", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_column_filter_groups_on_project_id"
    t.index ["table_id"], name: "index_column_filter_groups_on_table_id"
    t.index ["table_query_id"], name: "index_column_filter_groups_on_table_query_id"
  end

  create_table "columns", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "table_id", null: false
    t.string "key", null: false
    t.text "name"
    t.text "description"
    t.integer "position"
    t.boolean "not_null", default: false, null: false
    t.boolean "unique", default: false, null: false
    t.text "display_configuration"
    t.text "value_configuration"
    t.text "validation_configuration"
    t.text "storage_configuration"
    t.boolean "protected", default: false, null: false
    t.boolean "system", default: false, null: false
    t.string "type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_columns_on_project_id"
    t.index ["table_id", "key"], name: "index_columns_on_table_id_and_key", unique: true
    t.index ["table_id"], name: "index_columns_on_table_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "table_id"
    t.bigint "column_id"
    t.bigint "foreign_table_id"
    t.bigint "foreign_column_id"
    t.string "association_name"
    t.string "foreign_association_name"
    t.string "type", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["column_id", "foreign_column_id"], name: "index_relationships_on_column_id_and_foreign_column_id", unique: true
    t.index ["column_id"], name: "index_relationships_on_column_id"
    t.index ["foreign_column_id"], name: "index_relationships_on_foreign_column_id"
    t.index ["foreign_table_id", "foreign_association_name"], name: "index_relationships_on_foreign_table_association_name", unique: true
    t.index ["foreign_table_id"], name: "index_relationships_on_foreign_table_id"
    t.index ["project_id"], name: "index_relationships_on_project_id"
    t.index ["table_id", "association_name"], name: "index_relationships_on_table_association_name", unique: true
    t.index ["table_id"], name: "index_relationships_on_table_id"
  end

  create_table "table_queries", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "table_id", null: false
    t.string "key", null: false
    t.string "name"
    t.boolean "protected", default: false, null: false
    t.boolean "system", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id", "key"], name: "index_table_queries_on_project_id_and_key", unique: true
    t.index ["project_id"], name: "index_table_queries_on_project_id"
    t.index ["table_id"], name: "index_table_queries_on_table_id"
  end

  create_table "tables", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "key", null: false
    t.text "name"
    t.text "description"
    t.boolean "protected", default: false, null: false
    t.boolean "system", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id", "key"], name: "index_tables_on_project_id_and_key", unique: true
    t.index ["project_id"], name: "index_tables_on_project_id"
  end

  add_foreign_key "column_filter_conditions", "column_filter_groups", column: "filter_group_id"
  add_foreign_key "column_filter_conditions", "columns"
  add_foreign_key "column_filter_conditions", "projects"
  add_foreign_key "column_filter_conditions", "table_queries"
  add_foreign_key "column_filter_conditions", "tables"
  add_foreign_key "column_filter_groups", "projects"
  add_foreign_key "column_filter_groups", "table_queries"
  add_foreign_key "column_filter_groups", "tables"
  add_foreign_key "columns", "projects"
  add_foreign_key "columns", "tables"
  add_foreign_key "relationships", "columns"
  add_foreign_key "relationships", "columns", column: "foreign_column_id"
  add_foreign_key "relationships", "projects"
  add_foreign_key "relationships", "tables"
  add_foreign_key "relationships", "tables", column: "foreign_table_id"
  add_foreign_key "table_queries", "projects"
  add_foreign_key "table_queries", "tables"
  add_foreign_key "tables", "projects"
end
