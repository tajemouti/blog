require 'rails_helper'

RSpec.feature 'Post Show Page' do
  let!(:user1) { User.create(name: 'Ajrass', photo: 'https://avatars.githubusercontent.com/u/130588108?v=4') }
  let!(:post1) { Post.create(author_id: user1.id, title: 'Test post 1', text: 'Ruby on Rails.') }
  let!(:comment1) { Comment.create(user: user1, post: post1, text: 'Hello there!') }
  let!(:comment2) { Comment.create(user: user1, post: post1, text: 'Hi everyone!') }

  scenario 'Displays post title and author' do
    visit user_post_path(user1, post1)
    expect(page).to have_content(post1.title)
    expect(page).to have_content(user1.name)
  end

  scenario 'Displays how many comments and likes the post has' do
    visit user_post_path(user1, post1)
    expect(page).to have_content("Comments: #{post1.comments.count}")
    expect(page).to have_content("Likes: #{post1.likes.count}")
  end

  scenario 'Displays the post body' do
    visit user_post_path(user1, post1)

    expect(page).to have_content('Ruby on Rails.')
  end

  scenario 'Displays the username of each commentator' do
    visit user_post_path(user1, post1)
    expect(page).to have_content(comment1.user.name)
    expect(page).to have_content(comment2.user.name)
  end

  scenario 'Displays the comment left by each commentor' do
    visit user_post_path(user1, post1)
    expect(page).to have_content(comment1.text)
    expect(page).to have_content(comment2.text)
  end
end
