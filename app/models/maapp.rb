class Maapp < ActiveRecord::Base
  mount_uploader :W8BEN_form, W8BenFormUploader
  mount_uploader :file_id1, FileId1Uploader
  mount_uploader :file_id2, FileId2Uploader


  SSN_FORMAT = /\A\d{9}\z/
  PHONE_FORMAT =/\A\(?\d{3}[-\.)]?\d{3}[-\.]?\d{4}\z/
  PENNEMAIL_FORMAT = /\A[^@\s]+@(?:\w+\.)?upenn.edu\z/i
  EMAIL_FORMAT = /\A[^@\s]+@(?:\w+\.)+[a-z]{2,}\z/i

  # validates :first_name, :last_name, :student_status, :penn_affiliation,
  #           :local_address_line1, :local_address_city, :local_address_state, :local_address_zip,
  #           :perm_address_line1, :perm_address_city, :perm_address_state, :perm_address_zip,
  #           :statement_type, :checking_account, :visa_delivery, :address_on_checks, :check_type,
  #           :color, :check_delivery,
  #           presence: true
  # validate :dob_validation
  # validates :ssn, presence: true, format: {with: SSN_FORMAT}
  # validates :mobile_phone, format: {with: PHONE_FORMAT}
  # validates :home_phone, format: {with: PHONE_FORMAT, allow_blank: true}
  # validates :penn_email, format: {with: PENNEMAIL_FORMAT}
  # validates :alter_email, format: {with: EMAIL_FORMAT}
  validates :visa_pin, confirmation: true
  validates :visa_pin_confirmation, presence: true
  validates :terms, :understand, acceptance: true

  def dob_validation
    errors.add(:dob, "Date of Birth can't be blank.") unless dob.present?
    errors.add(:dob, "Date of Birth must be in the past.") if dob >= Date.today
  end

end

