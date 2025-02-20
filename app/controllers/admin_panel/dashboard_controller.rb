module AdminPanel
  class DashboardController < ApplicationController
    before_action :authenticate_admin!
    before_action :restrict_to_lan

    def index
      render plain: "Welcome to the Admin Panel!"
    end

    private

    def restrict_to_lan
      allowed_ips = Rails.configuration.admin_allowed_ips
      unless allowed_ips.any? { |ip| request.remote_ip.start_with?(ip) }
        render plain: "Not Found", status: :not_found
      end
    end
  end
end
