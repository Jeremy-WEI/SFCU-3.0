class AlappsController < ApplicationController
  include AlappsHelper
  before_action :set_alapp, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with :name => MainHelper.name, :password => MainHelper.password, except: [:new, :create, :successful]
  # GET /alapps
  # GET /alapps.json


  def index
    @alapps = Alapp.all
  end

  def successful
  end

  def export
      csv_path = "public/uploads/alapp/alapps_file.csv"
      create_csv(csv_path)

      zip_folder_path = "public/uploads/alapp"
      zip_files(zip_folder_path, csv_path, params[:exports])
  end

  def create_csv(file)
    @applicants = Alapp.find(params[:exports])

    # @header = Alapp.column_names

    File.open(file, "w") do |csv|
      tmp = ''
      Alapp.attribute_names.each do |attr|
        if attributes_translator[attr].nil?
          tmp << '"' << attr << '",'
        else
          tmp << '"' << attributes_translator[attr] << '",'
        end
      end
      tmp = tmp[0..-2]
      tmp << "\n"
      csv << tmp

      @applicants.each do |c|
        tmp = ''
        c.attributes.each  do | _,val|
          tmp << '"' << (val.nil? ? '':val.to_s) << '",'
        end
        tmp = tmp[0..-2]
        tmp << "\n"
        csv << tmp
      end
    end

  end

  def zip_files(folder_path, csv_path, export_lists)
    folder_path.sub!(%r[/$],'')
    archive = File.join(folder_path,File.basename(folder_path))+'.zip'
    FileUtils.rm archive, :force=>true
    Zip::ZipFile.open(archive, 'w') do |zipfile|
      Dir["#{folder_path}/**/**"].reject{|f|f==archive}.each do |file|
        applicantID = file.sub(folder_path +'/','').sub(/\/.*/, '')
        if export_lists.include?(applicantID)
          zipfile.add(file.sub(folder_path + '/',''),file)
        end
      end
      csv_name = csv_path.sub(folder_path + '/','')
      zipfile.add(csv_name, csv_path)
    end
    send_file(archive)

  end

  # GET /alapps/1
  # GET /alapps/1.json
  def show
  end

  # GET /alapps/new
  def new
    @alapp = Alapp.new
  end

  # GET /alapps/1/edit
  def edit
  end

  # POST /alapps
  # POST /alapps.json
  def create
    @alapp = Alapp.new(alapp_params)
    # if ["us", "united states"].include? @alapp.local_country.chomp.downcase
    #   lob_address
    # end
    respond_to do |format|
      if @alapp.save
        format.html { render :successful }
        # format.html { redirect_to @alapp, notice: 'Alapp was successfully created.' }
        # flash[:notice] = "You have successfully submitted the form!"
        # format.html { redirect_to alapps_path }
        format.json { render :show, status: :created, location: @alapp }
      else
        format.html { render :new }
        format.json { render json: @alapp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alapps/1
  # PATCH/PUT /alapps/1.json
  def update
    respond_to do |format|
      @alapp.update(alapp_params)
      format.html { redirect_to action: :index }
      format.json { render :show, status: :ok, location: @alapp }
        # format.html { redirect_to @alapp, notice: 'Alapp was successfully updated.' }
        # format.json { render :show, status: :ok, location: @alapp }
      # else
      #   format.html { render :edit }
      #   format.json { render json: @alapp.errors, status: :unprocessable_entity }
      # end
    end
  end

  # DELETE /alapps/1
  # DELETE /alapps/1.json
  def destroy
    @alapp.destroy
    respond_to do |format|
      format.html { redirect_to alapps_url, notice: 'Alapp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def attributes_translator
    {
        "id" => "Application id",
        "created_at" => "Created At",
        "updated_at" => "Updated At",
        "application_status" => "Application Status",

        "first" => "First Name",
        "middle" => "Middle Name",
        "last" => "Last Name",
        "dob" => "Date of Birth (yyyy/mm/dd)",
        "mother_maiden" => "Mother's Maiden Name",
        "ssn" => "SSN",
        "alumni" => "Penn Alumni",

        "credit_req_type" => "Credit Requirement Type",
        "amount_req" => "Amount Requested",
        "term" => "Term",

        "vehicle_condition" => "Vehicle Condition",
        "price_range_min" => "Vehicle Price Range Min",
        "price_range_max" => "Vehicle Price Range Max",
        "model_year" => "Vehicle Model Year",
        "veh_subcompact" => "Vehicle is subcompact",
        "veh_compact" => "Vehicle is compact",
        "veh_mid_size" => "Vehicle is middle size",
        "veh_full_size" => "Vehicle is full size",
        "veh_sports_car" => "Vehicle is sports car",
        "veh_truck" => "Vehicle is truck",
        "veh_van" => "Vehicle is van",

        "local_address_line1" => "Local Address Line 1",
        "local_address_line2" => "Local Address Line 2",
        "local_address_city" => "Local Address City",
        "local_address_state" => "Local Address State",
        "local_address_zip" => "Local Address ZIP",
        "local_country" => "Local Address Country",

        "perm_address_line1" => "Permanent Address Line 1",
        "perm_address_line2" => "Permanent Address Line 2",
        "perm_address_city" => "Permanent Address City",
        "perm_address_state" => "Permanent Address State",
        "perm_address_zip" => "Permanent Address ZIP",
        "perm_country" => "Permanent Address Country",

        "e_mail" => "Email",
        "phone_number" => "Phone",
        "name_nearest_relative" => "Name of the nearest relative",
        "phone_nearest_relative" => "Phone number of the nearest relative",

        "driver_lisence_num" => "Driver's License Number",
        "driver_license_file" => "Driver's License file",

        "employ1_employer" => "Employment Income 1, Employer",
        "employ1_employer_addr" => "Employment Income 1, Employer Address",
        "employ1_position" => "Employment Income 1, Position",
        "employ1_supervisor" => "Employment Income 1, Supervisor",
        "employ1_grosspay" => "Employment Income 1, Gross Pay",
        "employ1_freq" => "Employment Income 1, Pay Frequency",
        "employ1_continue" => "Employment Income 1, Will this job continue for term of this loan?",
        "employ1_expect_duration" => "Employment Income 1, If 'No', please list expected duration",

        "employ2_employer" => "Employment Income 2, Employer",
        "employ2_employer_addr" => "Employment Income 2, Employer Address",
        "employ2_position" => "Employment Income 2, Position",
        "employ2_supervisor" => "Employment Income 2, Supervisor",
        "employ2_grosspay" => "Employment Income 2, Gross Pay",
        "employ2_freq" => "Employment Income 2, Pay Frequency",
        "employ2_continue" => "Employment Income 2, Will this job continue for term of this loan?",
        "employ2_expect_duration" => "Employment Income 2, If 'No', please list expected duration",

        "employ3_employer" => "Employment Income 3, Employer",
        "employ3_employer_addr" => "Employment Income 3, Employer Address",
        "employ3_position" => "Employment Income 3, Position",
        "employ3_supervisor" => "Employment Income 3, Supervisor",
        "employ3_grosspay" => "Employment Income 3, Gross Pay",
        "employ3_freq" => "Employment Income 3, Pay Frequency",
        "employ3_continue" => "Employment Income 3, Will this job continue for term of this loan?",
        "employ3_expect_duration" => "Employment Income 3, If 'No', please list expected duration",
        "employ4_employer" => "Employment Income 4, Employer",
        "employ4_employer_addr" => "Employment Income 4, Employer Address",
        "employ4_position" => "Employment Income 4, Position",
        "employ4_supervisor" => "Employment Income 4, Supervisor",
        "employ4_grosspay" => "Employment Income 4, Gross Pay",
        "employ4_freq" => "Employment Income 4, Pay Frequency",
        "employ4_continue" => "Employment Income 4, Will this job continue for term of this loan?",
        "employ4_expect_duration" => "Employment Income 4, If 'No', please list expected duration",

        "add_income1_source" => "Additional Income 1, Source",
        "add_income1_amount" => "Additional Income 1, Amount",
        "add_income1_freq" => "Additional Income 1, Frequency",

        "add_income2_source" => "Additional Income 2, Source",
        "add_income2_amount" => "Additional Income 2, Amount",
        "add_income2_freq" => "Additional Income 2, Frequency",

        "add_income3_source" => "Additional Income 3, Source",
        "add_income3_amount" => "Additional Income 3, Amount",
        "add_income3_freq" => "Additional Income 3, Frequency",

        "add_income4_source" => "Additional Income 4, Source",
        "add_income4_amount" => "Additional Income 4, Amount",
        "add_income4_freq" => "Additional Income 4, Frequency",

        "account1_depository" => "Bank Account 1, Name of Depository",
        "account1_type" => "Bank Account 1, Type of Account",
        "account1_current_balance" => "Bank Account 1, Current Balance",

        "account2_depository" => "Bank Account 2, Name of Depository",
        "account2_type" => "Bank Account 2, Type of Account",
        "account2_current_balance" => "Bank Account 2, Current Balance",

        "account3_depository" => "Bank Account 3, Name of Depository",
        "account3_type" => "Bank Account 3, Type of Account",
        "account3_current_balance" => "Bank Account 3, Current Balance",

        "account4_depository" => "Bank Account 4, Name of Depository",
        "account4_type" => "Bank Account 4, Type of Account",
        "account4_current_balance" => "Bank Account 4, Current Balance",

        "property1_st_addr" => "Property Owned 1, Street Address",
        "property1_city" => "Property Owned 1, City",
        "property1_state" => "Property Owned 1, State",
        "property1_market_val" => "Property Owned 1, Market Value",
        "property1_another_loan" => "Property Owned 1, Pledged as Collateral for Another Loan?",

        "property2_st_addr" => "Property Owned 2, Street Address",
        "property2_city" => "Property Owned 2, City",
        "property2_state" => "Property Owned 2, State",
        "property2_market_val" => "Property Owned 2, Market Value",
        "property2_another_loan" => "Property Owned 2, Pledged as Collateral for Another Loan?",

        "property3_st_addr" => "Property Owned 3, Street Address",
        "property3_city" => "Property Owned 3, City",
        "property3_state" => "Property Owned 3, State",
        "property3_market_val" => "Property Owned 3, Market Value",
        "property3_another_loan" => "Property Owned 3, Pledged as Collateral for Another Loan?",

        "property4_st_addr" => "Property Owned 4, Street Address",
        "property4_city" => "Property Owned 4, City",
        "property4_state" => "Property Owned 4, State",
        "property4_market_val" => "Property Owned 4, Market Value",
        "property4_another_loan" => "Property Owned 4, Pledged as Collateral for Another Loan?",

        "credit_card1_name" => "Credit Card 1, Creditor Name",
        "credit_card1_limit" => "Credit Card 1, Credit Limit",
        "credit_card1_balance" => "Credit Card 1, Current Balance",
        "credit_card1_date_payment" => "Credit Card 1, Date of Next Payment",
        "credit_card1_aveg_month_pay" => "Credit Card 1, Average Monthly Payment",
        "credit_card1_pastdue" => "Credit Card 1, Past Due",

        "credit_card2_name" => "Credit Card 2, Creditor Name",
        "credit_card2_limit" => "Credit Card 2, Credit Limit",
        "credit_card2_balance" => "Credit Card 2, Current Balance",
        "credit_card2_date_payment" => "Credit Card 2, Date of Next Payment",
        "credit_card2_aveg_month_pay" => "Credit Card 2, Average Monthly Payment",
        "credit_card2_pastdue" => "Credit Card 2, Past Due",

        "credit_card3_name" => "Credit Card 3, Creditor Name",
        "credit_card3_limit" => "Credit Card 3, Credit Limit",
        "credit_card3_balance" => "Credit Card 3, Current Balance",
        "credit_card3_date_payment" => "Credit Card 3, Date of Next Payment",
        "credit_card3_aveg_month_pay" => "Credit Card 3, Average Monthly Payment",
        "credit_card3_pastdue" => "Credit Card 3, Past Due",

        "credit_card4_name" => "Credit Card 4, Creditor Name",
        "credit_card4_limit" => "Credit Card 4, Credit Limit",
        "credit_card4_balance" => "Credit Card 4, Current Balance",
        "credit_card4_date_payment" => "Credit Card 4, Date of Next Payment",
        "credit_card4_aveg_month_pay" => "Credit Card 4, Average Monthly Payment",
        "credit_card4_pastdue" => "Credit Card 4, Past Due",

        "loan1_name" => "Loan 1, Creditor Name",
        "loan1_type" => "Loan 1, Loan Type",
        "loan1_principal" => "Loan 1, Principal",
        "loan1_date_payment" => "Loan 1, Date of Next Payment",
        "loan1_month_payment" => "Loan 1, Monthly Payment",
        "loan1_pastdue" => "Loan 1, Past Due",

        "loan2_name" => "Loan 2, Creditor Name",
        "loan2_type" => "Loan 2, Loan Type",
        "loan2_principal" => "Loan 2, Principal",
        "loan2_date_payment" => "Loan 2, Date of Next Payment",
        "loan2_month_payment" => "Loan 2, Monthly Payment",
        "loan2_pastdue" => "Loan 2, Past Due",

        "loan3_name" => "Loan 3, Creditor Name",
        "loan3_type" => "Loan 3, Loan Type",
        "loan3_principal" => "Loan 3, Principal",
        "loan3_date_payment" => "Loan 3, Date of Next Payment",
        "loan3_month_payment" => "Loan 3, Monthly Payment",
        "loan3_pastdue" => "Loan 3, Past Due",

        "loan4_name" => "Loan 4, Creditor Name",
        "loan4_type" => "Loan 4, Loan Type",
        "loan4_principal" => "Loan 4, Principal",
        "loan4_date_payment" => "Loan 4, Date of Next Payment",
        "loan4_month_payment" => "Loan 4, Monthly Payment",
        "loan4_pastdue" => "Loan 4, Past Due",

        "rent_housing" => "Rent/Housing",
        "rent_person" => "Rent/Housing: If none, list the person who foots the expense",
        "food" => "Food",
        "food_person" => "Food: If none, list the person who foots the expense",
        "utilities" => "Utilities",
        "utilities_person" => "Utilities: If none, list the person who foots the expense",
        "phone_bill" => "Phone Bill",
        "phone_bill_person" => "Phone Bill: If none, list the person who foots the expense",
        "bursar_bill" => "Bursar Bill",
        "miscellaneous" => "Miscellaneous",
        "miscellaneous_expl" => "Explanation of miscellaneous expenses",
        "document1" => "document1",
        "document2" => "document2",
        "document3" => "document3",
        "document4" => "document4",
        "document5" => "document5",

        "agree_terms" => "Agree Terms",
        "signature" => "Signature",
        "today_date" => "Today's Date"
    }
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_alapp
    @alapp = Alapp.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def alapp_params
    params.require(:alapp).permit(:first, :middle, :last, :dob, :mother_maiden,
                                  :ssn, :alumni, :credit_req_type, :amount_req,
                                  :term, :vehicle_condition, :price_range_min,
                                  :price_range_max, :model_year, :veh_subcompact,
                                  :veh_compact, :veh_mid_size, :veh_full_size,
                                  :veh_sports_car, :veh_truck, :veh_van, :local_address_line1,
                                  :local_address_line2, :local_address_city,
                                  :local_address_state, :local_address_zip, :local_country,
                                  :perm_address_line1, :perm_address_line2, :perm_address_city,
                                  :perm_address_state, :perm_address_zip, :perm_country,
                                  :e_mail, :phone_number, :name_nearest_relative,
                                  :phone_nearest_relative, :driver_lisence_num,
                                  :driver_license_file, :employ1_employer, :employ1_employer_addr,
                                  :employ1_position, :employ1_supervisor, :employ1_grosspay,
                                  :employ1_freq, :employ1_continue, :employ1_expect_duration,
                                  :employ2_employer, :employ2_employer_addr, :employ2_position,
                                  :employ2_supervisor, :employ2_grosspay, :employ2_freq,
                                  :employ2_continue, :employ2_expect_duration,
                                  :add_income1_source, :add_income1_amount, :add_income1_freq,
                                  :add_income2_source, :add_income2_amount, :add_income2_freq,
                                  :add_income3_source, :add_income3_amount, :add_income3_freq,
                                  :account1_depository, :account1_type, :account1_current_balance,
                                  :account2_depository, :account2_type, :account2_current_balance,
                                  :account3_depository, :account3_type, :account3_current_balance,
                                  :account4_depository, :account4_type, :account4_current_balance,
                                  :property1_st_addr, :property1_city, :property1_state,
                                  :property1_market_val, :property1_another_loan,
                                  :property2_st_addr, :property2_city, :property2_state,
                                  :property2_market_val, :property2_another_loan,
                                  :credit_card1_name, :credit_card1_limit, :credit_card1_balance,
                                  :credit_card1_date_payment, :credit_card1_aveg_month_pay,
                                  :credit_card1_pastdue, :credit_card2_name, :credit_card2_limit,
                                  :credit_card2_balance, :credit_card2_date_payment,
                                  :credit_card2_aveg_month_pay, :credit_card2_pastdue,
                                  :credit_card3_name, :credit_card3_limit, :credit_card3_balance,
                                  :credit_card3_date_payment, :credit_card3_aveg_month_pay,
                                  :credit_card3_pastdue, :credit_card4_name, :credit_card4_limit,
                                  :credit_card4_balance, :credit_card4_date_payment,
                                  :credit_card4_aveg_month_pay, :credit_card4_pastdue,
                                  :loan1_name, :loan1_type, :loan1_principal, :loan1_date_payment,
                                  :loan1_month_payment, :loan1_pastdue, :loan2_name, :loan2_type,
                                  :loan2_principal, :loan2_date_payment, :loan2_month_payment,
                                  :loan2_pastdue, :loan3_name, :loan3_type, :loan3_principal,
                                  :loan3_date_payment, :loan3_month_payment, :loan3_pastdue,
                                  :loan4_name, :loan4_type, :loan4_principal, :loan4_date_payment,
                                  :loan4_month_payment, :loan4_pastdue, :rent_housing,
                                  :rent_person, :food, :food_person, :utilities, :utilities_person,
                                  :phone_bill, :phone_bill_person, :bursar_bill, :miscellaneous,
                                  :miscellaneous_expl, :document1, :document2, :document3,
                                  :document4, :document5, :agree_terms, :signature, :today_date,
                                  :property3_st_addr,
                                  :property3_city,
                                  :property3_state,
                                  :property3_market_val,
                                  :property3_another_loan,
                                  :property4_st_addr,
                                  :property4_city,
                                  :property4_state,
                                  :property4_market_val,
                                  :property4_another_loan,
                                  :add_income4_source,
                                  :add_income4_amount,
                                  :add_income4_freq,
                                  :employ3_employer,
                                  :employ3_employer_addr,
                                  :employ3_position,
                                  :employ3_supervisor,
                                  :employ3_grosspay,
                                  :employ3_freq,
                                  :employ3_continue,
                                  :employ3_expect_duration,
                                  :employ4_employer,
                                  :employ4_employer_addr,
                                  :employ4_position,
                                  :employ4_supervisor,
                                  :employ4_grosspay,
                                  :employ4_freq,
                                  :employ4_continue,
                                  :employ4_expect_duration,
                                  :same, :application_status)
  end

end
