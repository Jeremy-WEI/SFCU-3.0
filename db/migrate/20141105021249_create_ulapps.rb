class CreateUlapps < ActiveRecord::Migration
  def change
    create_table :ulapps do |t|
      t.integer :credit_type
      t.text :joint_applicant
      t.integer :amount
      t.text :purpose
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.integer :ssn
      t.string :sfcu_account
      t.string :name_relative
      t.integer :phone_relative
      t.string :mothers
      t.date :graduation
      t.string :local_address_line1
      t.string :local_address_line2
      t.string :local_address_city
      t.string :local_address_state
      t.integer :local_address_zip
      t.string :local_country
      t.integer :same
      t.string :perm_address_line1
      t.string :perm_address_line2
      t.string :perm_address_city
      t.string :perm_address_state
      t.integer :perm_address_zip
      t.string :perm_country
      t.string :e_mail
      t.integer :phone_number
      t.integer :phone_type
      t.integer :alter_number
      t.integer :alter_type
      t.string :employer
      t.string :employee_address_line1
      t.string :employee_address_line2
      t.string :employee_address_city
      t.string :employee_address_state
      t.integer :employee_address_zip
      t.string :employee_country
      t.string :position
      t.string :supervisor_firstname
      t.string :supervisor_lastname
      t.integer :grosspay
      t.integer :disbursement
      t.date :startingdate
      t.integer :continue
      t.text :no
      t.text :additional
      t.string :employer2
      t.string :employee2_address_line1
      t.string :employee2_address_line2
      t.string :employee2_address_city
      t.string :employee2_address_state
      t.integer :employee2_address_zip
      t.string :employee2_country
      t.string :position2
      t.string :supervisor2_firstname
      t.string :supervisor2_lastname
      t.integer :grosspay2
      t.integer :disbursement2
      t.date :startingdate2
      t.integer :continue2
      t.text :no2
      t.string :source1
      t.integer :amount1
      t.string :source2
      t.integer :amount2
      t.string :source3
      t.integer :amount3
      t.string :depository1
      t.integer :account_type1
      t.integer :balance1
      t.string :depository2
      t.integer :account_type2
      t.integer :balance2
      t.string :depository3
      t.integer :account_type3
      t.integer :balance3
      t.string :addr1
      t.integer :market_value1
      t.integer :pledged1
      t.string :addr2
      t.integer :market_value2
      t.integer :pledged2
      t.string :addr3
      t.integer :market_value3
      t.integer :pledged3
      t.string :creditor1
      t.integer :cbalance1
      t.date :nextpayment1
      t.integer :avg1
      t.integer :pastdue1
      t.string :creditor2
      t.integer :cbalance2
      t.date :nextpayment2
      t.integer :avg2
      t.integer :pastdue2
      t.string :creditor3
      t.integer :cbalance3
      t.date :nextpayment3
      t.integer :avg3
      t.integer :pastdue3
      t.string :creditor4
      t.integer :cbalance4
      t.date :nextpayment4
      t.integer :avg4
      t.integer :pastdue4
      t.string :loan_creditor1
      t.integer :creditor_type1
      t.date :first_payment1
      t.date :last_payment1
      t.integer :monthly1
      t.integer :past_due1
      t.string :loan_creditor2
      t.integer :creditor_type2
      t.date :first_payment2
      t.date :last_payment2
      t.integer :monthly2
      t.integer :past_due2
      t.text :expenses
      t.string :ulapp_file1
      t.string :file1
      t.string :file2
      t.string :file3
      t.string :file4
      t.string :file5
      t.string :file6
      t.boolean :yesorno
      t.string :signature

      t.timestamps
    end
  end
end
