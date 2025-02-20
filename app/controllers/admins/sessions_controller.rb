class Admins::SessionsController < Devise::SessionsController
  before_action :restrict_to_lan, only: [ :new, :create ]
  respond_to :html, :turbo_stream

  private

  def restrict_to_lan
    unless Rails.configuration.admin_allowed_ips.any? { |ip| request.remote_ip.start_with?(ip) }
      render plain: "Not Found", status: :not_found
    end
  end
end
