require 'file_size_validator'

class Maapp < ActiveRecord::Base
  mount_uploader :w8ben_form, W8BenFormUploader
  mount_uploader :file_id1, FileId1Uploader
  mount_uploader :file_id2, FileId2Uploader

  mount_uploader :w8ben_form, W8BenFormUploader
  mount_uploader :file_id1, IdPhotoUploader
  mount_uploader :file_id2, IdPhotoUploader

  SSN_FORMAT = /\A\d{9}\z/
  PHONE_FORMAT =/\A\(?\d{3}[-\.)]?\d{3}[-\.]?\d{4}\z/
  PENNEMAIL_FORMAT = /\A[^@\s]+@(?:\w+\.)*upenn.edu\z/i
  EMAIL_FORMAT = /\A[^@\s]+@(?:\w+\.)+[a-z]{2,}\z/i
  PENNCARD_NUMBER_FORMAT = /\A\d{16}\z/

  attr_accessor :grad_season, :same_perm_address
  before_validation :make_grad_year, :make_perm_address

  validates :w8ben_form,
            presence: true,
            file_size: {
                maximum: 5.megabytes.to_i
            }
  validates :file_id1, :file_id2,
            presence: true,
            file_size: {
                maximum: 5.megabytes.to_i
            }

<<<<<<< HEAD
  # validates :first_name, :last_name, :student_status, :penn_affiliation,
  #           :local_address_line1, :local_address_city, :local_address_state, :local_address_zip,
  #           :perm_address_line1, :perm_address_city, :perm_address_state, :perm_address_zip,
  #           :statement_type, :checking_account, :visa_delivery,
  #           presence: true
  # validate :dob_validation
  # validates :ssn, presence: true, format: {with: SSN_FORMAT}
  # validates :mobile_phone, format: {with: PHONE_FORMAT}
  # validates :home_phone, format: {with: PHONE_FORMAT, allow_blank: true}
  # validates :penn_email, format: {with: PENNEMAIL_FORMAT}, if: lambda { penn_affiliation == 'Graduate' || penn_affiliation == 'Undergraduate'}
  # validates :alter_email, format: {with: EMAIL_FORMAT}
  # validates :penncard_number, format: {with: PENNCARD_NUMBER_FORMAT}, if: lambda { penncard_link == true }
  # validates :check_type, :check_delivery, :address_on_checks, :color, presence: true, if: lambda {order_checks == true}
  validates :visa_pin, presence:true, confirmation: true, if: lambda {visa_checkcard == true}
  validates :visa_pin_confirmation, presence: true, if: lambda {visa_checkcard == true}
  validates :visa_delivery, presence: true, if: lambda {visa_checkcard == true}
=======
  validates :first_name, :last_name, :student_status, :penn_affiliation,
            :local_address_line1, :local_address_city, :local_address_state, :local_address_zip,
            :perm_address_line1, :perm_address_city, :perm_address_state, :perm_address_zip,
            :statement_type, :checking_account, :visa_delivery, :address_on_checks, :check_type,
            :color, :check_delivery,
            presence: true
  validate :dob_validation
  validates :ssn, presence: true, format: {with: SSN_FORMAT}
  validates :mobile_phone, format: {with: PHONE_FORMAT}
  validates :home_phone, format: {with: PHONE_FORMAT, allow_blank: true}
  validates :penn_email, format: {with: PENNEMAIL_FORMAT}
  validates :alter_email, format: {with: EMAIL_FORMAT}
  validates :visa_pin, confirmation: true
  validates :visa_pin_confirmation, presence: true
>>>>>>> b29eccfa15a294fd709a702cc28a780130fa3b69
  validates :terms, :understand, acceptance: true


  validates :w8ben_form,
            :presence => true,
            :file_size => {
                :maximum => 0.5.megabytes.to_i
            }

  def dob_validation
    errors.add(:dob, "Date of Birth can't be blank.") unless dob.present?
    errors.add(:dob, "Date of Birth must be in the past.") if dob >= Date.today
  end

<<<<<<< HEAD
  def make_grad_year
    self.grad_year = [grad_season, grad_year].join('-')
  end

  def make_perm_address
    if same_perm_address then
      self.perm_address_line1 = self.local_address_line1
      self.perm_address_line2 = self.local_address_line2
      self.perm_address_city = self.local_address_city
      self.perm_address_state = self.local_address_state
      self.perm_address_zip = self.local_address_zip
    end
  end
=======
>>>>>>> b29eccfa15a294fd709a702cc28a780130fa3b69

end

