class Type < ActiveRecord::Base
    has_many :clusters

    validates :name, presence: true
end
