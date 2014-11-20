class Ulapp < ActiveRecord::Base
  mount_uploader :ulapp_file1, UlappFile1Uploader
  validates :credit_type, presence: {message: "You must choose the credit type."}
  validates :amount, presence: {message: "Amount Requested cannot be blank."}
  validates :purpose, presence: {message: "Purpose cannot be blank."}
  validates :first_name, presence: {message: "First Name cannot be blank."}
  validates :last_name, presence: {message: "Last Name cannot be blank."}
  validates :name_relative, presence: {message: "Name of Nearest Relative cannot be blank."}
  validate :dob_must_be_in_the_past
  validates :phone_type, presence: {message: "Phone Type cannot be blank."}
  validates :alter_type, presence: {message: "Alternative Phone Type cannot be blank."}
  validates_format_of :ssn, {:with => /\A\d{9}\z/, message: "SSN must be 9 digits with no other symbols, e.g. 123456789"}
  validate :check_grad_date
  validates :employer, presence: {message: "Employer cannot be blank."}
  validates :supervisor_firstname, presence: {message: "First Name of Supervisor cannot be blank."}
  validates :supervisor_lastname, presence: {message: "Last Name of Supervisor cannot be blank."}
  validates :grosspay, presence: {message: "GrossPay cannot be blank."}
  validates_with UlappsHelper::PhoneValidator, fields: [:phone_relative, :phone_number]
  validate :check_alter
  validates_format_of :e_mail, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => "E_mail is invalid."
  validates :yesorno, acceptance: { accept: true, message: "You must agree with terms and conditions before submission."}




  def check_alter
    if alter_number.present?
      validates_with UlappsHelper::PhoneValidator, fields: [:alter_number]
    end
  end

  def dob_must_be_in_the_past
    if dob.present? && dob >= Date.today
      errors.add(:dob, "Date of birth must be in the past")
    end
  end

  def check_grad_date
    if not graduation.present?
      errors.add(:graduation, "Graduation date can't be blank")
    elsif graduation < Date.today
      errors.add(:graduation, "Graduation date must be in the future")
    end
  end

end