class Alapp < ActiveRecord::Base
  mount_uploader :driver_license_file, DriverLicenseFileUploader
  mount_uploader :document1, Document1Uploader
  mount_uploader :document2, Document2Uploader
  mount_uploader :document3, Document3Uploader
  mount_uploader :document4, Document4Uploader
  mount_uploader :document5, Document5Uploader


  has_many :employments
end
