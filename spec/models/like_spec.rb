require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'is valid with a user and a post' do
    user = User.create(name: 'John', post_counter: 0)
    post = user.posts.create(title: 'My Post', comments_counter: 0, likes_counter: 0)
    like = post.likes.new(user:)
    expect(like).to be_valid
  end

  it 'is not valid without a user' do
    post = Post.create(author: User.new, title: 'My Post', comments_counter: 0, likes_counter: 0)
    like = post.likes.new(user: nil)
    like.valid?
    expect(like.errors[:user]).to include('must exist')
  end

  it 'updates the likes counter for a post' do
    user = User.create(name: 'John', post_counter: 1)
    post = user.posts.create(title: 'My Post', comments_counter: 0, likes_counter: 0)
    like = post.likes.create(user:)

    like.increment_post_likes_counter

    post.reload
    expect(post.likes_counter).to eq(2)
  end
end
