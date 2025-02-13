class ContactController < ApplicationController
  def create
    respond_to do |format|
      if send_email
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            "contact_form_status",
            partial: "contact/success"
          )
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(
            "contact_form_status",
            partial: "contact/error"
          )
        end
      end
    end
  end

  private

  def send_email
    name = params[:name]
    email = params[:email]
    message = params[:message]

    ContactMailer.contact_email(name, email, message).deliver_now
    true
  rescue StandardError => e
    Rails.logger.error "Email failed: #{e.message}"
    false
  end
end
