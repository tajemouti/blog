require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a name, email, password, and a non-negative posts_counter' do
    user = User.new(name: 'Tom', email: 'tom@example.com', password: 'password', posts_counter: 3)
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user = User.new(name: nil, email: 'tom@example.com', password: 'password')
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it 'is not valid with a negative posts_counter' do
    user = User.new(name: 'Tom', email: 'tom@example.com', password: 'password', posts_counter: -1)
    user.valid?
    expect(user.errors[:posts_counter]).to include('must be greater than or equal to 0')
  end

  it 'returns the 3 most recent posts for a user' do
    user = User.new(name: 'Tom', email: 'tom@example.com', password: 'password')
    4.times { Post.create(author: user, title: 'My Post') }

    recent_posts = user.recent_posts

    expect(recent_posts.count).to eq(3)
    expect(recent_posts.first).to eq(user.posts.last)
  end
end
