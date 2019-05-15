class Author < ApplicationRecord
  before_save { self.name = name.titlecase }

  validates :name, uniqueness: true
  validates_presence_of :name

  has_many :author_books, dependent: :destroy
  has_many :books, through: :author_books

  def self.top_3_authors
    select("authors.*, avg(reviews.rating) as average_rating")
    .joins(books: :reviews)
    .group(:id)
    .order("average_rating DESC").limit(3)
  end
end
