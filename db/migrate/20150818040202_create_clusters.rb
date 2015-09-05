class CreateClusters < ActiveRecord::Migration
  def change
    create_table :clusters do |t|
      t.string :name
      t.integer :type_id
      t.integer :team_id
      t.datetime :lease

      t.timestamps null: false
    end
  end
end
