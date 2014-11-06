class Alapp < ActiveRecord::Base
  mount_uploader :driver_license_file, DriverLicenseFileUploader
  has_many :employments
end
