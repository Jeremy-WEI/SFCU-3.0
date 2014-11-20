module CbpappsHelper
  class PhoneValidator < ActiveModel::Validator
    def validate(record)
      options[:fields].each do |field|
        phone = record.send(field)
        unless phone.blank?
          phone_formats = [
              /^\d{10}/,
              /^\(\d\d\d\) \d\d\d-\d\d\d\d/,
              /^\d\d\d\.\d\d\d\.\d\d\d\d/,
              /^\d\d\d\-\d\d\d\-\d\d\d\d/
          ]
          valid = false
          phone_formats.each do |format|
            if phone.match( format )
              valid = true
            end
          end
          unless valid
            record.errors.add(field, "Format of #{field} isn't recognized")
          end
        end
      end
    end

  end
end
