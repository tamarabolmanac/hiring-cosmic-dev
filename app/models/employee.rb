class Employee < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :date_of_birth, presence: true
  validates :external_id, :email, presence: true, uniqueness: true
  validates :address, presence: true
end