require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'is valid with a title, comments_counter, and likes_counter within valid ranges' do
    user = User.create(name: 'Tom')
    post = Post.new(author: user, title: 'My Post', comments_counter: 0, likes_counter: 0)
    expect(post).to be_valid
  end

  it 'is not valid without a title' do
    User.create(name: 'Tom')
    post = Post.new(title: nil)
    post.valid?
    expect(post.errors[:title]).to include("can't be blank")
  end

  it 'is not valid with a title exceeding 250 characters' do
    user = User.create(name: 'Tom')
    post = Post.new(author: user, title: 'A' * 251)
    post.valid?
    expect(post.errors[:title]).to include('is too long (maximum is 250 characters)')
  end

  it 'is not valid with a negative comments_counter' do
    user = User.create(name: 'Tom')
    post = Post.new(author: user, title: 'My Post', comments_counter: -1)
    post.valid?
    expect(post.errors[:comments_counter]).to include('must be greater than or equal to 0')
  end

  it 'is not valid with a negative likes_counter' do
    User.create(name: 'Tom')
    post = Post.new(title: 'My Post', likes_counter: -1)
    post.valid?
    expect(post.errors[:likes_counter]).to include('must be greater than or equal to 0')
  end

  it 'updates the posts counter for a user' do
    user = User.new(name: 'Tom', email: 'tom@example.com', password: 'password', posts_counter: 0)
    post = Post.create(author: user, title: 'My Post')

    post.increment_user_posts_counter

    user.reload
    expect(user.posts_counter).to eq(2)
  end

  it 'returns the 5 most recent comments for a post' do
    user = User.new(name: 'Tom', email: 'tom@example.com', password: 'password')
    post = Post.create(author: user, title: 'My Post')
    6.times { Comment.create(user:, post:, text: 'Nice post!') }

    recent_comments = post.recent_comments

    expect(recent_comments.count).to eq(5)
    expect(recent_comments.first).to eq(post.comments.last)
  end
end
