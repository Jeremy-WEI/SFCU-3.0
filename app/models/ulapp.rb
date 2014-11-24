require 'file_size_validator'

class Ulapp < ActiveRecord::Base
  # mount_uploader :file1, File1Uploader
  # mount_uploader :file2, File2Uploader
  # mount_uploader :file3, File3Uploader
  # mount_uploader :file4, File4Uploader
  # mount_uploader :file5, File5Uploader
  # mount_uploader :file6, File6Uploader

  SFCU_ACCOUNT_FORMAT = /\A\d+\z/
  SSN_FORMAT = /\A\d{9}\z/
  EMAIL_FORMAT = /\A[^@\s]+@(?:\w+\.)+[a-z]{2,}\z/i

  validates :credit_type, :purpose, :first_name, :last_name,
            :name_relative, :phone_type, :alter_type, :employer,
            :supervisor_firstname, :supervisor_lastname, :grosspay,
            presence: true
  validates :amount, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true}
  validate :sfcu_account, format: {with: SFCU_ACCOUNT_FORMAT}
  validate :dob_validation
  validates :ssn, format: {with: SSN_FORMAT}
  validate :check_grad_date
  validates :grosspay, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true}
  validates_with UlappsHelper::PhoneValidator, fields: [:phone_relative, :phone_number]
  validate :check_alter
  validates :e_mail, format: {with: EMAIL_FORMAT}
  validates :yesorno, acceptance: true
  validates_with UlappsHelper::AmountValidator, fields: [:grosspay2, :amount1, :amount2, :amount3,
                                                         :balance1, :balance2, :balance3,
                                                         :market_value1, :market_value2, :market_value3,
                                                         :cbalance1, :cbalance2, :cbalance3, :cbalance4,
                                                         :avg1, :avg2, :avg3, :avg4, :monthly1, :monthly2]



  def check_alter
    if alter_number.present?
      validates_with UlappsHelper::PhoneValidator, fields: [:alter_number]
    end
  end

  def dob_validation
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