class RemoveavaliableFromCluster < ActiveRecord::Migration
  def change
    remove_column:clusters, :avaliable
  end
end
