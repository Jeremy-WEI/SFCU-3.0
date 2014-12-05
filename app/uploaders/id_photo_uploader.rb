# encoding: utf-8

class IdPhotoUploader < CarrierWave::Uploader::Base

  storage :file

  def extension_white_list
    %w(pdf jpg png gif bmp)
  end

  def filename
    "#{model.class.to_s.underscore}_#{mounted_as}.#{file.extension}" if original_filename
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{model.id}"

  end

end
