class Account < ActiveRecord::Base
    has_and_belongs_to_many :teams

    validates :email, presence: true, :uniqueness => true
    validates :name, presence: true 
end
