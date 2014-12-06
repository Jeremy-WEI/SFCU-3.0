class Cbpapp < ActiveRecord::Base

  SSN_FORMAT = /\A\d{9}\z/

  USERNAME = "test_58d0bda464b7082a64604d18519f94ec619"

  validates :first_name, :last_name, :mother_maiden,:account_number, :how_know,
            :local_home_phone, :local_address_line1, :local_address_city, :local_address_state,
            :student_status, :period,
            presence: true
  validates :ssn, format: {with: SSN_FORMAT}
  validate :check_dob, :check_non_upenn_email, :check_grad_date
  validates_with CbpappsHelper::PhoneValidator, fields: [:local_home_phone, :biz_phone, :perm_home_phone]
  validate :validates_local_address
  validate :validates_perm_address
  
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
    end
  end

  def empty_field? (field)
    return (field.nil? or field.to_s == '')
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
        end
      end
    end
  end

end


