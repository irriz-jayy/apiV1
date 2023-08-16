class Customer < ApplicationRecord
    has_many :appointments, dependent: :destroy

    has_secure_password

    validates :first_name, :surname,:phone_number, presence: true
    validates :email, uniqueness: true, presence: true
end
