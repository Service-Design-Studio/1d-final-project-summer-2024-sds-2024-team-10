class CustomerRecordsController < ApplicationController
  before_action :set_customer_record, only: %i[ show edit update destroy ]

  # GET /customer_records or /customer_records.json
  def index
    @customer_records = CustomerRecord.all
  end

  # GET /customer_records/1 or /customer_records/1.json
  def show
  end

  # GET /customer_records/new
  def new
    @customer_record = CustomerRecord.new
  end

  # GET /customer_records/1/edit
  def edit
  end

  # POST /customer_records or /customer_records.json
  def create
    @customer_record = CustomerRecord.new(customer_record_params)

    respond_to do |format|
      if @customer_record.save
        format.html { redirect_to customer_record_url(@customer_record), notice: "Customer record was successfully created." }
        format.json { render :show, status: :created, location: @customer_record }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @customer_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /customer_records/1 or /customer_records/1.json
  def update
    respond_to do |format|
      if @customer_record.update(customer_record_params)
        format.html { redirect_to customer_record_url(@customer_record), notice: "Customer record was successfully updated." }
        format.json { render :show, status: :ok, location: @customer_record }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @customer_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /customer_records/1 or /customer_records/1.json
  def destroy
    @customer_record.destroy!

    respond_to do |format|
      format.html { redirect_to customer_records_url, notice: "Customer record was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer_record
      @customer_record = CustomerRecord.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_record_params
      params.require(:customer_record).permit(:Identification, :Name, :PassportNo, :Nationality, :FIN, :DOD, :TelNo, :Address, :TaxID, :Accountpin, :Password)
    end
end
