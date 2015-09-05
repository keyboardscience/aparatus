class User < ActiveRecord::Base
    belongs_to :cluster

    validates :name, presence: true
end
