module AuthHelpers
  def sign_in_as(admin)
    post new_admin_session_path, params: { email: admin.email, password: "password" }
  end
end

RSpec.configure do |config|
  config.include AuthHelpers, type: :request
end
