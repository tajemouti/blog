require 'swagger_helper'

describe 'Posts API' do
  path '/api/v1/users/{user_id}/posts' do
    parameter name: :user_id, in: :path, type: :string

    get 'Retrieves all posts for a user' do
      produces 'application/json'
      response '200', 'Posts retrieved successfully' do
        run_test!
      end
    end
  end
end
