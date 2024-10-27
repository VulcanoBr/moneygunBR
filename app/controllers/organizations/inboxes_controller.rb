class Organizations::InboxesController < Organizations::BaseController
  before_action :set_inbox, only: %i[ show edit update destroy ]

  # GET /inboxes or /inboxes.json
  def index
    @inboxes = @organization.inboxes
    authorize @organization, policy_class: InboxPolicy
  end

  # GET /inboxes/1 or /inboxes/1.json
  def show
  end

  # GET /inboxes/new
  def new
    @inbox = @organization.inboxes.new
    authorize @inbox
  end

  # GET /inboxes/1/edit
  def edit
  end

  # POST /inboxes or /inboxes.json
  def create
    @inbox = @organization.inboxes.new(inbox_params)
    authorize @inbox

    respond_to do |format|
      if @inbox.save
        format.html { redirect_to organization_inbox_url(@organization, @inbox), notice: "Inbox was successfully created." }
        format.json { render :show, status: :created, location: @inbox }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @inbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /inboxes/1 or /inboxes/1.json
  def update
    respond_to do |format|
      if @inbox.update(inbox_params)
        format.html { redirect_to organization_inbox_url(@organization, @inbox), notice: "Inbox was successfully updated." }
        format.json { render :show, status: :ok, location: @inbox }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @inbox.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inboxes/1 or /inboxes/1.json
  def destroy
    @inbox.destroy!

    respond_to do |format|
      format.html { redirect_to organization_inboxes_url(@organization), notice: "Inbox was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inbox
      @inbox = @organization.inboxes.find(params[:id])
      authorize @inbox
    end

    # Only allow a list of trusted parameters through.
    def inbox_params
      params.require(:inbox).permit(:name)
    end
end