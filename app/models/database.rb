class Database < ActiveRecord::Base
    belongs_to :cluster
    validates :cluster_id, presence: true
    validates :name, presence: true
end
