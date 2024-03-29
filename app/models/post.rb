class Post < ApplicationRecord
  belongs_to :author, class_name: :User
  has_many :comments
  has_many :likes
  after_save :update_post_count

  validates :title, presence: true, length: { minimum: 1, maximum: 250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_post_count
    author.increment!(:post_counter)
  end
end
