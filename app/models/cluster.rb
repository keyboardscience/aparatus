class Cluster < ActiveRecord::Base
  belongs_to :team
  belongs_to :type
  has_many :users
  has_many :databases

  validates :name, :uniqueness => true, presence: true

  before_create :allocate_cluster
  before_update :update_cluster
  before_destroy :destroy_cluster

  private
  def allocate_cluster
    AnsibleJob.perform_later("#{ENV['RAILS_ENV']}", "playbook_database_servers", :extra_vars => {} )
  end

  def update_cluster
  end

  def destroy_cluster
  end
end
