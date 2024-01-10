class Post < ApplicationRecord
  belongs_to :author, class_name: :User, foreign_key: :author_id
  has_many :comments, foreign_key: :post_id
  has_many :likes, foreign_key: :user_id
  after_save :update_post_count

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def update_post_count
    author.increment!(:post_counter)
  end
end
