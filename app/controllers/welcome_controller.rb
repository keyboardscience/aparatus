class WelcomeController < ApplicationController
  def index
    @cluster = Cluster
    @account = Account
    @team = Team
    @database = Database
    @user = User
  end
end
