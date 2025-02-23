class RemoveUnusedIndexes < ActiveRecord::Migration[8.0]
  def change
    remove_index :pghero_query_stats, name: "index_pghero_query_stats_on_database_and_captured_at"
  end
end
