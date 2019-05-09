class Book < ApplicationRecord
  validates_presence_of :title, :pages, :published, :image

  has_many :author_books, dependent:  :destroy
  has_many :authors, through: :author_books
  has_many :reviews, dependent:  :destroy

  def reviews_count
    reviews.count(:id).presence || 0
  end

  def rating_avg
    reviews.average(:rating).presence || 0
  end

  def list_authors
    authors.map{|author| author.name}.compact.join(", ")
  end

  def co_authors(input_author)
    co_author = authors.map do |author|
      author.name unless author.id == input_author.id
    end.compact.join(", ")

    co_author.empty? ? "None" : co_author
  end

  def top_review
    reviews.where(rating: reviews.maximum(:rating)).first.presence || "NADA"
  end

  def self.sort_books_by(table)
    if table == "pagesASC"
      order("pages ASC")
    elsif table == "pagesDESC"
      order("pages DESC")
    elsif table == "countsASC"
      ratings_and_reviews("count_of_reviews", "ASC")
    elsif table == "countsDESC"
      ratings_and_reviews("count_of_reviews", "DESC")
    elsif table == "ratedASC"
      ratings_and_reviews("rating_avg", "ASC")
    else table == "ratedDESC"
      ratings_and_reviews("rating_avg", "DESC")
    end
  end

  private

  def self.ratings_and_reviews(table, direction)
    select("books.*, count(reviews) as count_of_reviews, avg(reviews.rating) as rating_avg")
    .left_joins(:reviews)
    .group(:id).order("#{table} #{direction} NULLS LAST",:title)
  end

end
