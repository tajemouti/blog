class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  after_initialize :set_defaults
  after_create :increment_user_post_counter

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def increment_user_post_counter
    author.increment!(:post_counter)
  end

  private

  def set_defaults
    self.comments_counter ||= 0
    self.likes_counter ||= 0
  end
end
