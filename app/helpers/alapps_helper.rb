module AlappsHelper
  def type_of_account
    [
        ['Checking', 'Checking'],
        ['Money Market', 'Money Market'],
        ['Savings', 'Savings'],
        ['Other', 'Other']
    ]
  end

  class AddressValidator < ActiveModel::Validator
    def validate(record)
      options[:fields].each do |field|

      end
    end
  end

  class PhoneValidator < ActiveModel::Validator

    def validate(record)
      options[:fields].each do |field|

        phone = record.send(field)
        if phone.blank?
          return
        else
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
            record.errors.add(field, "Format of phone number isn't recognized")
          end
        end
      end
    end

  end

  # class DollarValidator < ActiveModel::Validator
  #   def validate(record)
  #     options[:fields].each do |field|
  #       number = record.send(field)
  #       if number.blank?
  #         return
  #       elsif not (number >= 0.0)
  #         record.errors.add(field, "Amount of dollars is required in numeric and must be a positive number")
  #       end
  #     end
  #   end
  # end
end
