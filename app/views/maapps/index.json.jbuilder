json.array!(@maapps) do |applicant|
  json.extract! applicant, :id, :first_name, :middle_name, :last_name, :dob, :student_status, :penn_affiliation, :grad_year, :penn_id, :ssn, :W8BEN_form, :doc_type, :doc_id, :file_id1, :file_id2, :mobile_phone, :home_phone, :penn_email, :alter_email, :local_address_line1, :local_address_line2, :local_address_city, :local_address_state, :local_address_zip, :perm_address_line1, :perm_address_line2, :perm_address_city, :perm_address_state, :perm_address_zip, :statement_type, :checking_account, :courtesy_pay, :visa_checkcard, :visa_pin, :visa_delivery, :penncard_link, :penncard_number, :order_checks, :address_on_checks, :check_type, :color, :check_delivery, :signature, :apply_date
  json.url maapp_url(applicant, format: :json)
end
