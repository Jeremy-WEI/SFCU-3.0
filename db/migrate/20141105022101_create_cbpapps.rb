class CreateCbpapps < ActiveRecord::Migration
  def change
    create_table :cbpapps do |t|
      t.integer :period
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.integer :ssn
      t.date :dob
      t.string :mother_maiden
      t.integer :account_number
      t.integer :grad_date
      t.string :non_upenn_email
      t.string :how_know
      t.string :local_address_line1
      t.string :local_address_line2
      t.string :local_address_city
      t.string :local_address_state
      t.integer :local_address_zip
      t.string :local_home_phone
      t.string :biz_phone
      t.string :perm_address_line1
      t.string :perm_address_line2
      t.string :perm_address_city
      t.string :perm_address_state
      t.integer :perm_address_zip
      t.string :perm_address_country
      t.string :perm_home_phone
      t.integer :student_status

      t.timestamps
    end
  end
end
