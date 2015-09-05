class AddAvailableToClusters < ActiveRecord::Migration
  def change
    add_column :clusters, :available, :boolean
  end
end
