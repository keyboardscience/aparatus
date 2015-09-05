class CreateAccountsTeamsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :accounts, :teams do |t|
      t.index [:account_id, :team_id]
      t.index [:team_id, :account_id]
    end
  end
end
