require 'csv'

class TicketsController < ApplicationController
  before_action :set_ticket, only: [ :show, :edit, :update, :destroy ]
  before_action :set_tickets, only: [ :index]
  # GET /tickets or /tickets.json
  def index

  end

  # GET /tickets/1 or /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = current_user.tickets.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = current_user.tickets.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully created." }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update

    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def import
    # debugger
    file_path = params[:file]&.tempfile&.path
    ENV['USER_ID'] = current_user.id.to_s

    if file_path.present? && File.extname(file_path) == '.csv'
      ENV['CSV_FILE_PATH'] = file_path

      system('rake import_csv')
      flash[:notice] = 'CSV data imported successfully.'
    else
      flash[:error] = 'Invalid file. Please upload a CSV file.'
    end
    redirect_to tickets_path
  end

  def export
    if current_user.is_manager
      data = Ticket.all
    else
      data = current_user.tickets
    end

    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"exported_data.csv\""
        headers['Content-Type'] ||= 'text/csv'
        csv_data = CSV.generate do |csv|
          csv << Ticket.column_names
          data.each { |record| csv << record.attributes.values }
        end

        render plain: csv_data
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    def set_tickets
      if current_user.is_manager
        @tickets = Ticket.all
      else
        @tickets = current_user.tickets
      end

      set_ticket_counts
    end

    def set_ticket_counts
      @ticket_new = @tickets.where(status: 'new').count
      @ticket_pending = @tickets.where(status: 'pending').count
      @ticket_resolved = @tickets.where(status: 'resolved').count
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:requester_id, :status, :subject, :content)
    end
end
