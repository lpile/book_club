class Book < ApplicationRecord
  validates_presence_of :title, :pages, :published, :image

  has_many :author_books
  has_many :authors, through: :author_books
  has_many :reviews

  def reviews_count
    reviews.count(:id)
  end

  def rating_avg
    reviews.average(:rating)
  end

  def show_co_authors

  end
end
