class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  after_save :update_likes_count

  private

  def update_likes_count
    post.increment!(:likes_counter)
  end
end
