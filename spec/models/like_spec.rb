require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'is valid with a user and a post' do
    user = User.create(name: 'John')
    post = Post.create(author: user, title: 'My Post')
    like = Like.new(user:, post:)
    expect(like).to be_valid
  end

  it 'is not valid without a user' do
    post = Post.create(author: User.new, title: 'My Post')
    like = post.likes.new(user: nil)
    like.valid?
    expect(like.errors[:user]).to include('must exist')
  end

  it 'updates the likes counter for a post' do
    user = User.create(name: 'John', email: 'tom@example.com', password: 'password')
    post = Post.create(author: user, title: 'My Post')
    like = Like.create(user:, post:)

    like.increment_post_likes_counter

    post.reload
    expect(post.likes_counter).to eq(2)
  end
end
