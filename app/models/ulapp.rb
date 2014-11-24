require 'file_size_validator'

class Ulapp < ActiveRecord::Base

  mount_uploader :file1, NormalFileUploader
  mount_uploader :file2, NormalFileUploader
  mount_uploader :file3, NormalFileUploader
  mount_uploader :file4, NormalFileUploader
  mount_uploader :file5, NormalFileUploader
  mount_uploader :file6, NormalFileUploader

  SFCU_ACCOUNT_FORMAT = /\A\d+\z/
  SSN_FORMAT = /\A\d{9}\z/
  EMAIL_FORMAT = /\A[^@\s]+@(?:\w+\.)+[a-z]{2,}\z/i

  attr_accessor :same
  validates :file1, :file2, :file3, :file4, :file5, :file6,
            file_size: {
                maximum: 5.megabytes.to_i
            }

  before_validation :make_perm_address

  # validates :credit_type, :purpose, :first_name, :last_name,
  #           :name_relative, :phone_type, :alter_type, :employer,
  #           :supervisor_firstname, :supervisor_lastname,
  #           presence: true
  # validates :amount, numericality: { greater_than_or_equal_to: 0, only_integer: true}
  # validates :sfcu_account, format: {with: SFCU_ACCOUNT_FORMAT}
  # validates :e_mail, format: {with: EMAIL_FORMAT}
  # validates :ssn, format: {with: SSN_FORMAT}
  # validates :grosspay, numericality: { greater_than_or_equal_to: 0, only_integer: true}
  # validates_with UlappsHelper::PhoneValidator, fields: [:phone_relative, :phone_number]
  # validate :check_alter, :dob_validation, :check_grad_date
  # validates :yesorno, acceptance: true
  # validates_with UlappsHelper::AmountValidator, fields: [:grosspay2, :amount1, :amount2, :amount3,
  #                                                        :balance1, :balance2, :balance3,
  #                                                        :market_value1, :market_value2, :market_value3,
  #                                                        :cbalance1, :cbalance2, :cbalance3, :cbalance4,
  #                                                        :avg1, :avg2, :avg3, :avg4, :monthly1, :monthly2]

  def check_alter
    if alter_number.present?
      validates_with UlappsHelper::PhoneValidator, fields: [:alter_number]
    end
  end

  def dob_validation
    if dob.present? && dob >= Date.today
      errors.add(:dob, "must be in the past")
    end
  end

  def check_grad_date
    if not graduation.present?
      errors.add(:graduation, "can't be blank")
    elsif graduation < Date.today
      errors.add(:graduation, "must be in the future")
    end
  end

  def make_perm_address
    if same
      self.perm_address_line1 = self.local_address_line1
      self.perm_address_line2 = self.local_address_line2
      self.perm_address_city = self.local_address_city
      self.perm_address_state = self.local_address_state
      self.perm_address_zip = self.local_address_zip
    end
  end

end