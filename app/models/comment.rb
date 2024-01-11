class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  after_save :update_comment_count

  private

  def update_comment_count
    post.increment!(:comments_counter)
  end
end
