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
    AnsibleJob.perform_later("#{ENV['RAILS_ENV']}", "allocate_cluster.yml" )
  end

  def update_cluster
    AnsibleJob.perform_later("#{ENV['RAILS_ENV']}", "update_cluster.yml" )
  end

  def destroy_cluster
    AnsibleJob.perform_later("#{ENV['RAILS_ENV']}", "destroy_cluster.yml" )
  end
end
