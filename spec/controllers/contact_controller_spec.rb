require 'rails_helper'

RSpec.describe ContactController, type: :controller do
  describe "POST #create" do
    it "responds with success and renders the success turbo stream" do
      post :create, params: { name: "John", email: "john@example.com", message: "Hello!" }, format: :turbo_stream

      expect(response.status).to eq(200)
      expect(response.content_type).to include("text/vnd.turbo-stream.html")
    end
  end
end
