class Alapp < ActiveRecord::Base
  mount_uploader :driver_license_file, DriverLicenseFileUploader
    mount_uploader :document1, Document1Uploader
    mount_uploader :document2, Document2Uploader
    mount_uploader :document3, Document3Uploader
    mount_uploader :document4, Document4Uploader
    mount_uploader :document5, Document5Uploader

  validates :first, presence:  {message: "First name can't be blank"}
  validates_presence_of :last, message: "Last name can't be blank"
  #validates_presence_of :dob, message: "Date of birth can't be blank"
  validate :check_dob
  validates_presence_of :ssn, message: "Social security number can't be blank"
  validates_presence_of :mother_maiden, message: "Mother's maiden name can't be blank"
  validates_presence_of :alumni, message: "Are you an alumni of Penn?"
  validates_format_of :ssn, {:with => /\A\d{9}\z/, message: "SSN must be 9 digits with no other symbols, for example: 123456789"}
  validates :credit_req_type, presence: {message: "You must select a credit request type"}

  validates :amount_req, presence: {message: "amount is required (in dollars) and must be in numerical form" }
  validates :amount_req, numericality: { greater_than_or_equal_to: 0.0, message: "amount is required (in dollars) and must be a positive number" }

  validates :term, presence:  {message: "What is your requested term of loan?"}
  validates :vehicle_condition, presence:  {message: "What is the condition of your vehicle?"}
  validate :validates_vehicle_price_range
  validates :price_range_min, numericality: { greater_than_or_equal_to: 0.0, message: "Price range is required and must be a positive number"  }
  validates :price_range_max, numericality: { greater_than_or_equal_to: :price_range_min, message: "Maximum price must be numeric and larger than minimum price"  }
  validate :validates_vehicle_type

  validates :e_mail, presence: {message: "Email can't be blank"}
  validates_format_of :e_mail, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message: "Invalid email"
  validates :phone_number, presence: {message: "Phone number can't be blank"}
  validates_presence_of :name_nearest_relative, message: "Nearest relative name can't be blank"
  validates_presence_of :phone_nearest_relative, message: "Phone number of the nearest relative can't be blank"
  validates_with AlappsHelper::PhoneValidator, fields: [:phone_number, :phone_nearest_relative]

  validates :driver_lisence_num, presence:  {message: "Driver's license can't be blank"}
  validates :driver_license_file, presence:  {message: "You must upload a driver's license file"}


  validates :employ1_grosspay, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :employ2_grosspay, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :add_income1_amount, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :add_income2_amount, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :add_income3_amount, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :account1_current_balance, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :account2_current_balance, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :account3_current_balance, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :account4_current_balance, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :property1_market_val, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :property2_market_val, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :credit_card1_limit, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :credit_card1_balance, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :credit_card1_aveg_month_pay, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :credit_card2_limit, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :credit_card2_balance, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :credit_card2_aveg_month_pay, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :credit_card3_limit, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :credit_card3_balance, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :credit_card3_aveg_month_pay, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :credit_card4_limit, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :credit_card4_balance, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :credit_card4_aveg_month_pay, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :loan1_principal, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :loan1_month_payment, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :loan2_principal, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :loan2_month_payment, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :loan3_principal, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :loan3_month_payment, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :loan4_principal, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :loan4_month_payment, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :rent_housing, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :food, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :utilities, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :phone_bill, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :bursar_bill, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true
  validates :miscellaneous, numericality: {greater_than_or_equal_to: 0.0, message: "amount must be positive and in numeric form" }, allow_nil: true


   validates :agree_terms, acceptance:  {message: "You must agree the terms in order to submit the form"}
   validates :signature, presence:  {message: "You must agree the terms and sign in order to submit the form"}
   validates :today_date, presence:  {message: "You must agree the terms and fill in today's date to submit the form"}

  #validates_with AlappsHelper::DollarValidator, fields: [:employ1_grosspay]


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

  def check_non_upenn_email
    if not non_upenn_email.present?
      errors.add(:non_upenn_email, "Non upenn email can't be blank")
    elsif validates_format_of :non_upenn_email, :with =>  /\A([^@\s]+)@(.+)upenn.edu/i
      errors.add(:non_upenn_email, "Cannot use upenn email")
    end
  end

  has_many :employments
end
