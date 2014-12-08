require "file_size_validator"

class Alapp < ActiveRecord::Base
  
  USERNAME = "test_58d0bda464b7082a64604d18519f94ec619"
  
  mount_uploader :driver_license_file, NormalFileUploader
  mount_uploader :document1, NormalFileUploader
  mount_uploader :document2, NormalFileUploader
  mount_uploader :document3, NormalFileUploader
  mount_uploader :document4, NormalFileUploader
  mount_uploader :document5, NormalFileUploader

  before_validation :make_perm_address
  attr_accessor :same
  validates :agree_terms, acceptance: true
  # validates :driver_license_file,
  #           presence: true,
  #           :file_size => {
  #               :maximum => 5.megabytes.to_i
  #           }
  validates :document1, :document3, :document4, :document5, :document2,
            :file_size => {
                :maximum => 5.megabytes.to_i
            }



  has_many :employments

  SSN_FORMAT = /\A\d{9}\z/
  EMAIL_FORMAT = /\A[^@\s]+@(?:\w+\.)+[a-z]{2,}\z/i
  PHONE_FORMAT =/\A\(?\d{3}[-\.)]?\d{3}[-\.]?\d{4}\z/

  validates :first, :last, :mother_maiden, :credit_req_type,
            :term, :vehicle_condition, :name_nearest_relative, :phone_nearest_relative,
            :driver_lisence_num, :signature, :today_date, :local_address_state,:local_address_zip, :local_address_line1,
            :local_address_city, :local_country,
            presence: true

  validate :check_dob
  validates :ssn, format: {with: SSN_FORMAT}

  validates :amount_req, numericality: { greater_than_or_equal_to: 0.0}, allow_blank: false

  validates :price_range_min, numericality: { greater_than_or_equal_to: 0.0}, allow_blank: false
  validates :price_range_max, numericality: { greater_than_or_equal_to: 0.0}, allow_blank: false
  validate :validates_vehicle_price_range

  # validate :validates_amount_req_present?
  validate :validates_vehicle_type
  validate :validates_local_address
  validate :validates_perm_address
  validate :validates_alumni

  validates :e_mail, format: {with: EMAIL_FORMAT}
  validates :phone_number, :phone_nearest_relative, format: {with: PHONE_FORMAT}


  validates :employ1_grosspay, :employ2_grosspay,       :employ3_grosspay,            :employ4_grosspay,
            :add_income1_amount,          :add_income2_amount,          :add_income3_amount,          :add_income4_amount,
            :account1_current_balance,    :account2_current_balance,    :account3_current_balance,    :account4_current_balance,
            :property1_market_val,        :property2_market_val,        :property3_market_val,        :property4_market_val,
            :credit_card1_limit,          :credit_card2_limit,          :credit_card3_limit,          :credit_card4_limit,
            :credit_card1_balance,        :credit_card2_balance,        :credit_card3_balance,        :credit_card4_balance,
            :credit_card1_aveg_month_pay, :credit_card2_aveg_month_pay, :credit_card3_aveg_month_pay, :credit_card4_aveg_month_pay,
            :loan1_principal,             :loan2_principal,             :loan3_principal,             :loan4_principal,
            :loan1_month_payment,         :loan2_month_payment,         :loan3_month_payment,         :loan4_month_payment,
            :rent_housing, :food, :utilities, :phone_bill, :bursar_bill, :miscellaneous,
            allow_blank: true, numericality: {greater_than_or_equal_to: 0.0}


  def validates_alumni
    if alumni.nil? or alumni == ""
      errors.add(:alumni, "Alumni can't be blank")
    elsif alumni == "t" or alumni == "yes" or alumni == "true"
      self.alumni = "Yes"
    elsif alumni == "f" or alumni == "no" or alumni == "false"
      self.alumni = "No"
    end
  end

  def check_dob
    if not dob.present?
      errors.add(:dob, "Date of birth can't be blank")
    elsif dob >= Date.today
      errors.add(:dob, "Date of birth must be in the past")
    end
  end


  def validates_vehicle_price_range
    if price_range_max.to_i < price_range_min.to_i
      errors.add(:price_range_max, "Maximum price must be numeric and larger than minimum price")
    end
  end

  def validates_vehicle_type
    unless veh_subcompact == true or veh_compact == true or veh_mid_size == true or veh_full_size == true or veh_sports_car == true or veh_truck == true or veh_van == true
      errors.add(:veh_subcompact, "You must choose a vehicle type")
      errors.add(:veh_compact, "You must choose a vehicle type")
      errors.add(:veh_mid_size, "You must choose a vehicle type")
      errors.add(:veh_full_size, "You must choose a vehicle type")
      errors.add(:veh_sports_car, "You must choose a vehicle type")
      errors.add(:veh_truck, "You must choose a vehicle type")
      errors.add(:veh_van, "You must choose a vehicle type")
    end
  end


  def empty_field? (field)
    return (field.nil? or field.to_s == '')
  end

  def validates_local_address
    self.local_country = "" if self.local_country.nil?
    if ["us", "united states"].include? self.local_country.chomp.downcase
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
        self.local_country = @result["address"]["address_country"]
      rescue
        errors.add(:local_address_line1, "Invalid address")
        # errors.add(:local_address_line2, "Invalid address")
        errors.add(:local_address_city, "Invalid address")
        errors.add(:local_address_state, "Invalid address")
        errors.add(:local_country, "Invalid address")
        errors.add(:local_address_zip, "Invalid address")
      end
    end
  end

  def validates_perm_address
    self.perm_country = "" if self.perm_country.nil?
    if ["us", "united states"].include? self.perm_country.chomp.downcase
      if empty_field?(perm_address_line1) and empty_field?(perm_address_line2) #if not filled (perm address not required)
        self.perm_address_city, self.perm_address_zip, self.perm_address_state, self.perm_country = "", "", "", "", ""
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
          self.perm_country = @result["address"]["address_country"]
        rescue
          errors.add(:perm_address_line1, "Invalid address")
          # errors.add(:perm_address_line2, "Invalid address")
          errors.add(:perm_address_city, "Invalid address")
          errors.add(:perm_address_state, "Invalid address")
          errors.add(:perm_country, "Invalid address")
          errors.add(:perm_address_zip, "Invalid address")
        end
      end
    end
  end

  def make_perm_address
    if same == "1"
      self.perm_address_line1 = self.local_address_line1
      self.perm_address_line2 = self.local_address_line2
      self.perm_address_city = self.local_address_city
      self.perm_address_state = self.local_address_state
      self.perm_address_zip = self.local_address_zip
      self.perm_country = self.local_country
    end
  end

end
