class Book < ApplicationRecord
  validates_presence_of :title, :pages, :published, :image

  has_many :author_books, dependent:  :destroy
  has_many :authors, through: :author_books
  has_many :reviews, dependent:  :destroy

  validates :title, uniqueness: true

  def reviews_count
    reviews.count(:id)
  end

  def rating_avg
    reviews.average(:rating)
  end

  def review_description
    if reviews.empty?
      "No Reviews"
    else
      "Rating: #{rating_avg} Reviews: #{reviews_count}"
    end
  end

  def list_authors
    authors.pluck(:name)
  end

  def co_authors(input_author)
    authors.where.not(id: input_author).pluck(:name)
  end

  def top_review
    reviews.where(rating: reviews.maximum(:rating)).first || "No Reviews"
  end

  def top_3_reviews
    reviews.order("rating DESC").first(3) || "No Reviews"
  end

  def bottom_3_reviews
    reviews.order("rating").first(3) || "No Reviews"
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
