class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  after_create :increment_post_comments_counter

  def increment_post_comments_counter
    post.increment!(:comments_counter)
  end
end
