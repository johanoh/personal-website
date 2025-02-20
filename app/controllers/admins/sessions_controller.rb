class Admins::SessionsController < Devise::SessionsController
  before_action :restrict_to_lan, only: [ :new, :create, :destroy ]
  respond_to :html, :turbo_stream

  def create
    super do |resource|
      flash.delete(:notice) # Prevent Devise's default flash messages
      respond_with resource, location: after_sign_in_path_for(resource)
      return
    end
  end

  def destroy
    sign_out(:admin) # Explicitly sign out the `Admin` model
    redirect_to root_path, allow_other_host: false, status: :see_other
  end

  private

  def after_sign_in_path_for(resource)
    admin_panel_root_path # Redirects to /admin_panel after login
  end

  def restrict_to_lan
    unless Rails.configuration.admin_allowed_ips.any? { |ip| request.remote_ip.start_with?(ip) }
      render file: Rails.public_path.join("404.html"), status: :not_found, layout: false
    end
  end
end
