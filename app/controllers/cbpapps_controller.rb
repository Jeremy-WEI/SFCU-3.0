class CbpappsController < ApplicationController
  before_action :set_cbpapp, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with :name => MainHelper.name, :password => MainHelper.password, except: [:new, :create, :successful]
  # GET /cbpapps
  # GET /cbpapps.json
  def index
    @cbpapps = Cbpapp.all
  end

  # GET /cbpapps/1
  # GET /cbpapps/1.json
  def show
  end

  # GET /cbpapps/new
  def new
    @cbpapp = Cbpapp.new
  end

  # GET /cbpapps/1/edit
  def edit
  end

  def successful

  end

  def export
      csv_path = "public/uploads/cbpapp/cbpapps_file.csv"
      create_csv(csv_path)

      zip_folder_path = "public/uploads/cbpapp"
      zip_files(zip_folder_path, csv_path, params[:exports])
  end

  def create_csv(file)
    @applicants = Cbpapp.find(params[:exports])

    @header = Cbpapp.column_names

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

  # POST /cbpapps
  # POST /cbpapps.json
  def create
    @cbpapp = Cbpapp.new(cbpapp_params)

    respond_to do |format|
      if @cbpapp.save
        # format.html { redirect_to @cbpapp, notice: 'Cbpapp was successfully created.' }
        format.html { render :successful }
        # format.html { redirect_to action: :index }
        format.json { render :show, status: :created, location: @cbpapp }
      else
        format.html { render :new }
        format.json { render json: @cbpapp.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cbpapps/1
  # PATCH/PUT /cbpapps/1.json
  def update
    respond_to do |format|
      @cbpapp.update(cbpapp_params)
      format.html { redirect_to action: :index }
        # format.html { redirect_to @cbpapp, notice: 'Cbpapp was successfully updated.' }
        # format.json { render :show, status: :ok, location: @cbpapp }
      # else
      #   format.html { render :edit }
      #   format.json { render json: @cbpapp.errors, status: :unprocessable_entity }
      # end
    end
  end

  # DELETE /cbpapps/1
  # DELETE /cbpapps/1.json
  def destroy
    @cbpapp.destroy
    respond_to do |format|
      format.html { redirect_to cbpapps_url, notice: 'Cbpapp was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cbpapp
      @cbpapp = Cbpapp.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cbpapp_params
      params.require(:cbpapp).permit(:application_status, :period, :first_name, :middle_name, :last_name, :ssn, :dob, :mother_maiden, :account_number, :grad_date, :non_upenn_email, :how_know, :local_address_line1, :local_address_line2, :local_address_city, :local_address_state, :local_address_zip, :local_home_phone, :biz_phone, :perm_address_line1, :perm_address_line2, :perm_address_city, :perm_address_state, :perm_address_zip, :perm_address_country, :perm_home_phone, :student_status)
    end
end
