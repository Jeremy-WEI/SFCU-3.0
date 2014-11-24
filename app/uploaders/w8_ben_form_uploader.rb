# encoding: utf-8

class W8BenFormUploader < CarrierWave::Uploader::Base

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  def extension_white_list
    %w(pdf jpg)
  end

  def filename
    "#{model.class.to_s.underscore}_#{mounted_as}.#{file.extension}" if original_filename
  end

end
