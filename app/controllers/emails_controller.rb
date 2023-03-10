class EmailsController < ApplicationController
  before_action :set_email, only: %i[ show edit update destroy ]
  require 'faker'

    def index
        @emails = Email.all
    end

    def show
        @email = Email.find(params[:id])
        respond_to do |format|
            format.turbo_stream
            format.html
        end
    end

    def new
        @emails = Email.all
    end

    def create
        @email = Email.new(object: Faker::Lorem.sentence(word_count: 3), body: Faker::Lorem.sentence(word_count: 20))
        if @email.save
            redirect_to root_path
            flash[:notice] = "Email created"
        else
            redirect_to root_path
            flash[:notice] = "Please try again"
        end
    end

  # PATCH/PUT /emails/1 or /emails/1.json
  def update

   

    respond_to do |format|
      if @email.update(email_params)
        format.html { redirect_to email_url(@email), notice: "Email was successfully updated." }
        format.json { render :show, status: :ok, location: @email }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @email.errors, status: :unprocessable_entity }
       
    end
  end
  

  # DELETE /emails/1 or /emails/1.json
  def destroy
    @email.destroy

    respond_to do |format|
      format.html { redirect_to emails_url, notice: "Email was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def email_params
      params.require(:email).permit(:object, :body)
    end
  end
end