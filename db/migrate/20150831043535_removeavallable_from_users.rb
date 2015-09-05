class RemoveavallableFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :avallable
  end
end
