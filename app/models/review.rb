class Review < ApplicationRecord
  validates_presence_of :title, :user, :rating, :comment

  belongs_to :book

  def self.sort_reviews(table)
    if table == "reviewsasc"
      order("created_at ASC")
    elsif table == "reviewsdesc"
      order("created_at DESC")
    end
  end
end
