require 'rails_helper'

RSpec.describe "Users controller", type: :request do
  describe "GET /users" do
    before do
      get users_path
    end
    
    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "renders the 'index' template" do
      expect(response).to render_template("index")
    end

    it "includes 'List of all users' in the response body" do
      expect(response.body).to include("List of all users")
    end
  end
end
