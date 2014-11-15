class Alapp < ActiveRecord::Base
  mount_uploader :driver_license_file, DriverLicenseFileUploader
  mount_uploader :document1, Document1Uploader
  mount_uploader :document2, Document2Uploader
  mount_uploader :document3, Document3Uploader
  mount_uploader :document4, Document4Uploader
  mount_uploader :document5, Document5Uploader

  validates_presence_of :first, message: "First name can't be blank"
  validates_presence_of :last, message: "Last name can't be blank"
  validates_presence_of :dob, message: "Date of birth can't be blank"
  validate :dob_must_be_in_the_past
  validates_presence_of :ssn, message: "Social security number can't be blank"
  validates_presence_of :mother_maiden, message: "Mother's maiden name can't be blank"
  validates_presence_of :alumni, message: "Are you an alumni of Penn?"




  def dob_must_be_in_the_past
    if dob.present? && dob >= Date.today
      errors.add(:dob, "Date of birth must be in the past")
    end
  end


  has_many :employments
end
