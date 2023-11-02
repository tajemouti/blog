class User < ApplicationRecord
  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end

  def update_post_counter
    update(post_counter: posts.count)
  end
end
