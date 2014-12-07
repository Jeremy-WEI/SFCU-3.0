require 'file_size_validator'

class Maapp < ActiveRecord::Base

  USERNAME = "test_58d0bda464b7082a64604d18519f94ec619" #for lob API

  mount_uploader :w8ben_form, W8BenFormUploader
  mount_uploader :file_id1, IdPhotoUploader
  mount_uploader :file_id2, IdPhotoUploader

  SSN_FORMAT = /\A\d{9}\z/
  PHONE_FORMAT =/\A\(?\d{3}[-\.\)]?\d{3}[-\.]?\d{4}\z/
  PENNEMAIL_FORMAT = /\A[^@\s]+@(?:\w+\.)*upenn.edu\z/i
  EMAIL_FORMAT = /\A[^@\s]+@(?:\w+\.)+[a-z]{2,}\z/i
  PENNCARD_NUMBER_FORMAT = /\A\d{16}\z/

  attr_accessor :grad_season, :same_perm_address, :other_penn_affiliation
  before_validation :make_grad_year, :make_perm_address, :make_penn_affiliation

  validates :w8ben_form,
            presence: true,
            file_size: {
                maximum: 5.megabytes.to_i
            }, if: lambda { not ssn.present? }
  validates :file_id1, :file_id2,
            presence: true,
            file_size: {
                maximum: 5.megabytes.to_i
            }


  validates :first_name, :last_name, :student_status, :penn_affiliation,
            :local_address_line1, :local_address_city, :local_address_state, :local_address_zip,
            :perm_address_line1, :perm_address_city, :perm_address_state, :perm_address_zip,
            :statement_type, :checking_account, :signature,
            presence: true
  validate :dob_validation
  validates :ssn, format: {with: SSN_FORMAT, allow_blank: true}
  validates :mobile_phone, format: {with: PHONE_FORMAT}
  validates :home_phone, format: {with: PHONE_FORMAT, allow_blank: true}
  validates :penn_email, format: {with: PENNEMAIL_FORMAT}, if: lambda { penn_affiliation == 'Graduate' || penn_affiliation == 'Undergraduate'}
  validates :alter_email, format: {with: EMAIL_FORMAT}
  validates :penncard_number, format: {with: PENNCARD_NUMBER_FORMAT}, if: lambda { penncard_link == true }
  validates :check_type, :check_delivery, :address_on_checks, :color, presence: true, if: lambda {order_checks == true}
  validate :validates_local_address
  validate :validates_perm_address
  validates :visa_pin, presence:true, confirmation: true, if: lambda {visa_checkcard == true}
  validates :visa_pin_confirmation, presence: true, if: lambda {visa_checkcard == true}
  validates :visa_delivery, presence: true, if: lambda {visa_checkcard == true}
  validates :terms, :understand, acceptance: true


  def dob_validation
    errors.add(:dob, "Date of Birth can't be blank.") unless dob.present?
    errors.add(:dob, "Date of Birth must be in the past.") if dob.present? and dob >= Date.today
  end

  def make_penn_affiliation
    if self.penn_affiliation == 'others' and self.other_penn_affiliation.present?
      self.penn_affiliation = self.other_penn_affiliation
    end
  end

  def make_grad_year
    self.grad_year = [grad_season, grad_year].join('-')
  end

  def empty_field? (field)
    return (field.nil? or field.to_s == '')
  end

  def validates_local_address
    begin
      @lob = Lob.load(api_key: USERNAME)
      @result = @lob.addresses.verify(
          address_line1: self.local_address_line1,
          address_line2: self.local_address_line2,
          city: self.local_address_city,
          state: self.local_address_state,
          zip: self.local_address_zip
      )
      self.local_address_line1 = @result["address"]["address_line1"]
      self.local_address_line2 = @result["address"]["address_line2"]
      self.local_address_city = @result["address"]["address_city"]
      self.local_address_state = @result["address"]["address_state"]
      self.local_address_zip = @result["address"]["address_zip"]
    rescue
      errors.add(:local_address_line1, "Invalid address")
      errors.add(:local_address_city, "Invalid address")
      errors.add(:local_address_state, "Invalid address")
      errors.add(:local_address_zip, "Invalid address")
    end
  end

  def validates_perm_address
    self.perm_address_country = "" if self.perm_address_country.nil?
    if ["us", "united states"].include? self.perm_address_country.chomp.downcase
      if empty_field?(perm_address_line1) and empty_field?(perm_address_line2) #if not filled (perm address not required)
        [self.perm_address_city, self.perm_address_zip, self.perm_address_state, self.perm_address_country].map {|x| x = ""}
      else
        begin
          @lob = Lob.load(api_key: USERNAME)
          @result = @lob.addresses.verify(
              address_line1: self.perm_address_line1,
              address_line2: self.perm_address_line2,
              city: self.perm_address_city,
              state: self.perm_address_state,
              zip: self.perm_address_zip
          )
          self.perm_address_line1 = @result["address"]["address_line1"]
          self.perm_address_line2 = @result["address"]["address_line2"]
          self.perm_address_city = @result["address"]["address_city"]
          self.perm_address_state = @result["address"]["address_state"]
          self.perm_address_zip = @result["address"]["address_zip"]
          self.perm_address_country = @result["address"]["address_country"]
        rescue
          errors.add(:perm_address_line1, "Invalid address")
          errors.add(:perm_address_line2, "Invalid address")
          errors.add(:perm_address_city, "Invalid address")
          errors.add(:perm_address_state, "Invalid address")
          errors.add(:perm_address_country, "Invalid address")
          errors.add(:perm_address_zip, "Invalid address")
        end
      end
    end
  end

  def make_perm_address
    if same_perm_address == '1' then
      self.perm_address_line1 = self.local_address_line1
      self.perm_address_line2 = self.local_address_line2
      self.perm_address_city = self.local_address_city
      self.perm_address_state = self.local_address_state
      self.perm_address_zip = self.local_address_zip
      self.perm_address_country = "US"
    end
  end

end





