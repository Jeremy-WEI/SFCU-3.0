module UlappsHelper
  class PhoneValidator < ActiveModel::Validator

    def validate(record)
      options[:fields].each do |field|

        phone = record.send(field)
        if phone.blank?
          record.errors.add(field, "#{field} cannot be blank.")
        else
          phone_formats = [
              /^\d{10}\z/,
              /^\(\d\d\d\) \d\d\d-\d\d\d\d\z/,
              /^\d\d\d\.\d\d\d\.\d\d\d\d\z/,
              /^\d\d\d\-\d\d\d\-\d\d\d\d\z/
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

  class AmountValidator < ActiveModel::Validator

    def validate(record)
      options[:fields].each do |field|
        amount = record.send(field)
        if not amount.blank?
          if not amount =~ /\A\d+\z/
            record.errors.add(field, "The format of #{field} is invalid.")
          end
        end
      end
    end
  end

end
