class ContactMailer < ApplicationMailer
  default to: Rails.application.credentials.dig(:sendgrid, :to_email), from: Rails.application.credentials.dig(:sendgrid, :from_email)

  def contact_email(name, email, message)
    @name = name
    @message = message
    @email = email

    mail(
      from: Rails.application.credentials.dig(:sendgrid, :from_email), # Set your verified domain email
      reply_to: email, # Allows you to reply directly to the sender
      subject: "New Contact Form Message from #{@name}"
    )
  end
end
