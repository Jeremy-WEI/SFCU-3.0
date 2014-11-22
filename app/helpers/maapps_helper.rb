module MaappsHelper
  class FileSizeValidator < ActiveModel::Validator
    def validate(record)
      options[:fields].each do |field|
        file = record.send(field)
        if file.size > 5.megabytes
          record.errors.add(field, "Size of #{field} should be less than 5M.")
        elsif file.size == 0.megabytes
          record.errors.add(field, "#{field} should be present.")
        end
      end
    end
  end
end
