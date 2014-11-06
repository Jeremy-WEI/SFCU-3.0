class CreateMaapps < ActiveRecord::Migration
  def change
    create_table :maapps do |t|
      t.string :first
      t.string :middle
      t.string :last
      t.date :dob
      t.integer :student_status
      t.integer :penn_affiliation
      t.integer :grad_year
      t.integer :penn_id
      t.integer :ssn
      t.string :file_ssn
      t.string :doc_type
      t.integer :doc_id
      t.string :file_id1
      t.string :file_id2
      t.integer :mobile_phone
      t.integer :home_phone
      t.string :penn_email
      t.string :alter_email
      t.string :local_address_line1
      t.string :local_address_line2
      t.string :local_address_city
      t.string :local_address_state
      t.integer :local_address_zip
      t.string :perm_address_line1
      t.string :perm_address_line2
      t.string :perm_address_city
      t.string :perm_address_state
      t.integer :perm_address_zip
      t.boolean :statement_type_paper
      t.boolean :statement_type_electronic
      t.integer :checking_account
      t.boolean :courtesy_pay
      t.boolean :visa_check_card
      t.integer :visa_pin
      t.integer :visa_repeat_pin
      t.integer :visa_delivery
      t.boolean :penncard_link
      t.integer :penncard_number
      t.boolean :order_checks
      t.integer :address_on_checks
      t.integer :check_type
      t.string :color
      t.string :check_delivery
      t.boolean :term
      t.boolean :understand
      t.string :signature
      t.date :today_date

      t.timestamps
    end
  end
end
