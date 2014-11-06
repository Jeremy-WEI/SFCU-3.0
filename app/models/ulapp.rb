class Ulapp < ActiveRecord::Base
  mount_uploader :ulapp_file1, UlappFile1Uploader
end
