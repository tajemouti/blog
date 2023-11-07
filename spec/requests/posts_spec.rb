require 'rails_helper'

RSpec.describe "Posts controller", type: :request do
  describe "GET /users/user_id/posts" do
    before do
      user = User.create(name: "Tom", post_counter: 0)
      get user_posts_path(user)
    end

    it "returns a 200 status code" do
      expect(response).to have_http_status(200)
    end

    it "renders the 'index' template" do
      expect(response).to render_template("index")
    end

    it "includes 'All posts by User' in the response body" do
      expect(response.body).to include("All posts by User")
    end
  end
end
