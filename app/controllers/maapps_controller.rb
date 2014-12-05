class MaappsController < ApplicationController
  before_action :set_maapp, only: [:show, :edit, :update, :destroy]

  # GET /maapps
  # GET /maapps.json
  def index
    @maapps = Maapp.all
  end

  # GET /maapps/1
  # GET /maapps/1.json
  def show
  end

  # GET /maapps/new
  def new
    @maapp = Maapp.new
  end

  # GET /maapps/1/edit
  def edit
  end

  # POST /maapps
  # POST /maapps.json
  def create
    @maapp = Maapp.new(maapp_params)

    respond_to do |format|
      if @maapp.save
        format.html { redirect_to action: :index }
        format.json { render :show, status: :created, location: @maapp }
      else
        format.html { render :new }
        format.json { render json: @maapp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /maapps/1
  # PATCH/PUT /maapps/1.json
  def update
    respond_to do |format|
      @maapp.update(maapp_params)
      # if @maapp.update(maapp_params)
        # format.html { redirect_to @maapp, notice: 'Maapp was successfully updated.' }
        format.html { redirect_to action: :index }
        # format.json { render :show, status: :ok, location: @maapp }
      # else
      #   format.html { render :edit }
      #   format.json { render json: @maapp.errors, status: :unprocessable_entity }
      # end
    end
  end

  def export
    if params[:exports].nil?
      @maapps = Maapp.all
      render :index
    else
      csv_path = "public/uploads/maapp/maapps_file.csv"
      create_csv(csv_path)


      zip_folder_path = "public/uploads/maapp"
      zip_files(zip_folder_path, csv_path, params[:exports])
    end

  end

  def create_csv(file)
    @applicants = Maapp.find(params[:exports])

    @header = Maapp.column_names

    File.open(file, "w") do |csv|
      tmp = ''
      @header.each do |attr|
        tmp << '"' << attr << '",'
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
    send_file(file)
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
  end

  # DELETE /maapps/1
  # DELETE /maapps/1.json
  def destroy
    @maapp.destroy
    respond_to do |format|
      format.html { redirect_to maapps_url, notice: 'Maapp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_maapp
      @maapp = Maapp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def maapp_params
      params.require(:maapp).permit(:other_penn_affiliation, :application_status, :first_name, :middle_name, :last_name, :dob, :student_status, :penn_affiliation, :grad_season, :grad_year, :penn_id, :ssn, :w8ben_form, :doc_type, :doc_id, :file_id1, :file_id2, :mobile_phone, :home_phone, :penn_email, :alter_email, :local_address_line1, :local_address_line2, :local_address_city, :local_address_state, :local_address_zip, :same_perm_address, :perm_address_line1, :perm_address_line2, :perm_address_city, :perm_address_state, :perm_address_zip, :statement_type, :checking_account, :courtesy_pay, :visa_checkcard, :visa_pin, :visa_pin_confirmation, :visa_delivery, :penncard_link, :penncard_number, :order_checks, :address_on_checks, :check_type, :color, :check_delivery, :signature, :terms, :understand)
    end
end
