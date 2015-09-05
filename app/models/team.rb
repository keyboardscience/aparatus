class Team < ActiveRecord::Base
    has_and_belongs_to_many :accounts
    has_many :clusters

    validates :name, presence: true
end
