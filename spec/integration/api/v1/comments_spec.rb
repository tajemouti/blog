require 'swagger_helper'

describe 'Comments API' do
  path '/api/v1/users/{user_id}/posts/{post_id}/comments' do
    parameter name: :user_id, in: :path, type: :string
    parameter name: :post_id, in: :path, type: :string

    get 'Retrieves all comments for a post' do
      produces 'application/json'
      response '200', 'Comments retrieved successfully' do
        run_test!
      end
    end

    post 'Creates a comment for a post' do
      consumes 'application/json'
      parameter name: :comment, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string }
        },
        required: ['text']
      }

      response '201', 'Comment created successfully' do
        let(:comment) { { text: 'This is a comment on the post' } }
        run_test!
      end

      response '422', 'Invalid request' do
        let(:comment) { { } }
        run_test!
      end
    end
  end
end
