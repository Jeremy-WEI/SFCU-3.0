require "file_size_validator"

class Alapp < ActiveRecord::Base

  mount_uploader :driver_license_file, NormalFileUploader
  mount_uploader :document1, NormalFileUploader
  mount_uploader :document2, NormalFileUploader
  mount_uploader :document3, NormalFileUploader
  mount_uploader :document4, NormalFileUploader
  mount_uploader :document5, NormalFileUploader
  before_validation :make_perm_address

  validates :driver_license_file,
            presence: true,
            :file_size => {
                :maximum => 5.megabytes.to_i
            }
  validates :document1, :document3, :document4, :document5, :document2,
            :file_size => {
                :maximum => 5.megabytes.to_i
            }


  has_many :employments

  SSN_FORMAT = /\A\d{9}\z/
  EMAIL_FORMAT = /\A[^@\s]+@(?:\w+\.)+[a-z]{2,}\z/i
  PHONE_FORMAT =/\A\(?\d{3}[-\.)]?\d{3}[-\.]?\d{4}\z/

  validates :first, :last, :alumni, :mother_maiden, :credit_req_type,
            :term, :vehicle_condition, :name_nearest_relative, :phone_nearest_relative,
            :driver_lisence_num, :signature, :today_date,
            presence: true
  validate :check_dob
  validates :ssn, format: {with: SSN_FORMAT}

  validates :amount_req, numericality: { greater_than_or_equal_to: 0.0}

  validate :validates_vehicle_price_range
  validates :price_range_min, numericality: { greater_than_or_equal_to: 0.0}
  validates :price_range_max, numericality: { greater_than_or_equal_to: :price_range_min}
  validate :validates_vehicle_type
  validate :validates_local_address
  validate :validates_local_address

  validates :e_mail, format: {with: EMAIL_FORMAT}
  validates :phone_number, :phone_nearest_relative, format: {with: PHONE_FORMAT}


  validates :employ1_grosspay, :employ2_grosspay, :employ3_grosspay,
            :account1_current_balance, :account2_current_balance, :account3_current_balance, :account4_current_balance,
            :property1_market_val, :property2_market_val,
            :rent_housing, :food, :utilities, :phone_bill, :bursar_bill, :miscellaneous,
            numericality: {greater_than_or_equal_to: 0.0}, allow_nil: true

   validates :agree_terms, acceptance: true

  def check_dob
    if not dob.present?
      errors.add(:dob, "Date of birth can't be blank")
    elsif dob >= Date.today
      errors.add(:dob, "Date of birth must be in the past")
    end
  end

  def validates_vehicle_price_range
    if not price_range_min.present?
      errors.add(:price_range_min, "Price range required and must be in numerical form")
    end
    if not price_range_max.present?
      errors.add(:price_range_max, "Price range required and must be in numerical form")
    end
  end

  def validates_vehicle_type
    if not (veh_subcompact.present? or veh_compact.present? or veh_mid_size.present? or veh_full_size.present? or veh_sports_car.present? or veh_truck.present? or veh_van.present?)
      errors.add(:veh_type, "You must choose a vehicle type")
    end
  end

  def validates_local_address
    begin
      @username = "test_58d0bda464b7082a64604d18519f94ec619"
      @lob = Lob.load(api_key: @username)
      @result = @lob.addresses.verify(
          address_line1: local_address_line1,
          address_line2: local_address_line2,
          city: local_address_city,
          state: local_address_state,
          zip: local_address_zip
      )

    rescue
      errors.add(:local_address_line1, "Invalid address")
    end
  end

  def validates_perm_address
    begin
      @username = "test_58d0bda464b7082a64604d18519f94ec619"
      @lob = Lob.load(api_key: @username)
      @result = @lob.addresses.verify(
          address_line1: perm_address_line1,
          address_line2: perm_address_line2,
          city: perm_address_city,
          state: perm_address_state,
          zip: perm_address_zip,
          country: perm_country
      )
    rescue
      errors.add(:perm_address_line1, "Invalid address")
    end
  end

  def make_perm_address
    if same == 1
      self.perm_address_line1 = self.local_address_line1
      self.perm_address_line2 = self.local_address_line2
      self.perm_address_city = self.local_address_city
      self.perm_address_state = self.local_address_state
      self.perm_address_zip = self.local_address_zip
      self.perm_country = self.local_country
    end
  end

end
