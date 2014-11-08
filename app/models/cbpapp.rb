class Cbpapp < ActiveRecord::Base

  validates :period, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :ssn, length: {is: 9, message: "is not a valid SSN"}
  # validates :dob, presence: true
  # validates :mother_maiden, presence: true
  validates :account_number, presence: true

end
