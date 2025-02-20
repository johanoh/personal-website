module AdminPanel
  class DashboardController < ApplicationController
    before_action :authenticate_admin!
    before_action :restrict_to_lan

    def index
      render "admin_panel/dashboard/index"
    end

    private

    def restrict_to_lan
      allowed_ips = Rails.configuration.admin_allowed_ips
      unless allowed_ips.any? { |ip| request.remote_ip.start_with?(ip) }
        render file: Rails.public_path.join("404.html"), status: :not_found, layout: false
      end
    end
  end
end
