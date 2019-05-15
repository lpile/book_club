class Review < ApplicationRecord
  before_save { self.title = title.titlecase }
  before_save { self.user = user.titlecase }
  before_save { self.comment = comment.capitalize }
  
  validates_presence_of :title, :user, :rating, :comment

  belongs_to :book

  def self.sort_reviews(table)
    if table == "reviewsasc"
      order("created_at ASC")
    elsif table == "reviewsdesc"
      order("created_at DESC")
    elsif table == "ratingsasc"
      order("rating ASC, created_at ASC")
    elsif table == "ratingsdesc"
      order("rating DESC, created_at DESC")
    end
  end

  def self.sort_user(input_user)
    where(user: input_user)
  end
end
