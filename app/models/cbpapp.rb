class Cbpapp < ActiveRecord::Base
  validates :first_name, presence: {message: "First name can't be blank"}
  validates :last_name, presence: {message: "Last name can't be blank"}
  validates :ssn, length: {is: 9, message: "Invalid SSN"}
  validate :check_dob
  validates :mother_maiden, presence: {message: "Mother's maiden name can't be blank"}
  validates :account_number, presence: {message: "SFCU account number can't be blank"}
  validate :check_grad_date
  validate :check_non_upenn_email
  validates :how_know, presence: {message: "How did you hear about the program can't be blank"}

  validates :local_home_phone, presence: {message: "Local home phone can't be blank"}
  validates_with CbpappsHelper::PhoneValidator, fields: [:local_home_phone, :biz_phone, :perm_home_phone]

  validates :local_address_line1, presence: {message: "Local address line 1 can't be blank"}
  validates :local_address_city, presence: {message: "Local address city can't be blank"}
  validates :local_address_state, presence: {message: "Local address state can't be blank"}

  validates :student_status, presence: {message: "Student status can't be blank"}
  validates :period, presence: {message: "Period can't be blank"}


  def check_dob
    if not dob.present?
      errors.add(:dob, "Date of birth can't be blank")
    elsif dob > Date.today
      errors.add(:dob, "Date of birth must be in the past")
    end
  end


  def check_grad_date
    if not grad_date.present?
      errors.add(:grad_date, "Graduation date can't be blank")
    elsif grad_date < Date.today
      errors.add(:grad_date, "Graduation date must be in the future")
    end
  end

  def check_non_upenn_email
    if not non_upenn_email.present?
      errors.add(:non_upenn_email, "Non upenn email can't be blank")
    elsif not non_upenn_email =~ /\A[^@\s]+@(?:\w+\.)+[a-z]{2,}\z/i
      errors.add(:non_upenn_email, "The email format is invalid.")
    elsif non_upenn_email =~ /\A([^@\s]+)@(?:\w+\.)*upenn.edu\z/i
      errors.add(:non_upenn_email, "Cannot use upenn email")
    end
  end


end


