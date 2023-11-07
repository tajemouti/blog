require 'rails_helper'

RSpec.describe 'Posts controller', type: :request do
  describe 'GET /users/user_id/posts' do
    before do
      user = User.create(name: 'Tom', post_counter: 0)
      get user_posts_path(user)
    end

    it 'returns a 200 status code' do
      expect(response).to have_http_status(200)
    end

    it "renders the 'index' template" do
      expect(response).to render_template('index')
    end

    it "includes 'All posts by User' in the response body" do
      expect(response.body).to include('All posts by User')
    end
  end

  describe 'GET /users/user_id/posts/post_id' do
    before do
      user = User.create(name: 'Tom', post_counter: 0)
      post = user.posts.create(title: 'My Post', comments_counter: 0, likes_counter: 0)
      get user_post_path(user, post)
    end

    it 'returns a 200 status code' do
      expect(response).to have_http_status(200)
    end

    it "renders the 'show' template" do
      expect(response).to render_template('show')
    end

    it "includes 'Specific post by a Specific User' in the response body" do
      expect(response.body).to include('Specific post by a Specific User')
    end
  end
end
