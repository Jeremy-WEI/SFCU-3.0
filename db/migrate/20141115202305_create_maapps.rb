class CreateMaapps < ActiveRecord::Migration
  def change
    create_table :maapps do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.date :dob
      t.string :student_status
      t.string :penn_affiliation
      t.integer :grad_year
      t.string :penn_id
      t.string :ssn
      t.string :W8BEN_form
      t.string :doc_type
      t.string :doc_id
      t.string :file_id1
      t.string :file_id2
      t.string :mobile_phone
      t.string :home_phone
      t.string :penn_email
      t.string :alter_email
      t.string :local_address_line1
      t.string :local_address_line2
      t.string :local_address_city
      t.string :local_address_state
      t.string :local_address_zip
      t.string :perm_address_line1
      t.string :perm_address_line2
      t.string :perm_address_city
      t.string :perm_address_state
      t.string :perm_address_zip
      t.string :statement_type
      t.string :checking_account
      t.boolean :courtesy_pay
      t.boolean :visa_checkcard
      t.string :visa_pin
      t.string :visa_delivery
      t.boolean :penncard_link
      t.string :penncard_number
      t.boolean :order_checks
      t.string :address_on_checks
      t.string :check_type
      t.string :color
      t.string :check_delivery
      t.string :signature
      t.date :apply_date

      t.timestamps
    end
  end
end
