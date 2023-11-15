require 'rails_helper'

RSpec.feature 'User show page' do
  let!(:user1) { User.create(name: 'Ajrass', bio: 'A student from Morocco', photo: 'https://avatars.githubusercontent.com/u/130588108?v=4') }
  let!(:post1) { Post.create(author: user1, title: 'Post 01') }
  let!(:post2) { Post.create(author: user1, title: 'Post 02') }
  let!(:post3) { Post.create(author: user1, title: 'Post 03') }
  let!(:post4) { Post.create(author: user1, title: 'Post 04') }

  scenario 'Displays user Profile picture, username, bio and number of posts' do
    visit user_path(user1)
    expect(page).to have_css("img[src='#{user1.photo}']")
    expect(page).to have_content(user1.name)
    expect(page).to have_content(user1.bio)
    expect(page).to have_content("Number of posts: #{user1.posts_counter}")
  end

  scenario 'Displays user 3 posts' do
    visit user_path(user1)

    expect(page).to have_content(post1.title)
    expect(page).to have_content(post3.title)
  end

  scenario 'Displays Button that lets me view all of a user posts, and redirects to the posts when clicked' do
    visit user_path(user1)
    expect(page).to have_link('See all posts')
    click_link 'See all posts'
    sleep(1)
    expect(current_path).to eq(user_posts_path(user1))
  end

  scenario 'click on user post redirects to that post show page.' do
    visit user_path(user1)

    click_link post1.title
    sleep(1)
    expect(current_path).to eq(user_post_path(user1, post1))
  end
end
