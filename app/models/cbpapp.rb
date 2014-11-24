class Cbpapp < ActiveRecord::Base

  SSN_FORMAT = /\A\d{9}\z/

  validates :first_name, :last_name, :mother_maiden,:account_number, :how_know,
            :local_home_phone, :local_address_line1, :local_address_city, :local_address_state,
            :student_status, :period,
            presence: true
  validates :ssn, format: {with: SSN_FORMAT}
  validate :check_dob, :check_non_upenn_email, :check_grad_date
  validates_with CbpappsHelper::PhoneValidator, fields: [:local_home_phone, :biz_phone, :perm_home_phone]

  def check_dob
    if not dob.present?
      errors.add(:dob, "can't be blank")
    elsif dob > Date.today
      errors.add(:dob, "must be in the past")
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
      errors.add(:non_upenn_email, "can't be blank")
    elsif not non_upenn_email =~ /\A[^@\s]+@(?:\w+\.)+[a-z]{2,}\z/i
      errors.add(:non_upenn_email, "format is invalid.")
    elsif non_upenn_email =~ /\A([^@\s]+)@(?:\w+\.)*upenn.edu\z/i
      errors.add(:non_upenn_email, "cannot be upenn email")
    end
  end


end


