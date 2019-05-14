class Book < ApplicationRecord
  before_save { self.title = title.titlecase }
  validates_presence_of :title, :pages, :published, :image

  has_many :author_books, dependent:  :destroy
  has_many :authors, through: :author_books
  has_many :reviews, dependent:  :destroy

  validates :title, uniqueness: true

  def reviews_count
    reviews.count(:id)
  end

  def rating_avg
    reviews.average(:rating) || 0
  end

  def review_users
    reviews.pluck(:user)
  end

  def review_description
    if reviews.empty?
      "No Reviews"
    else
      "Rating: #{rating_avg.round(1)} Reviews: #{reviews_count}"
    end
  end

  def list_authors
    authors.pluck(:name)
  end

  def co_authors(input_author)
    authors.where.not(id: input_author).pluck(:name)
  end

  def top_review
    reviews.where(rating: reviews.maximum(:rating)).first
  end

  def top_3_reviews
    reviews.order("rating DESC").first(3) || "No Reviews"
  end

  def bottom_3_reviews
    reviews.order("rating").first(3) || "No Reviews"
  end

  def self.top_3_authors
    select("authors.id as authors_id, authors.name as author_name, avg(reviews.rating) as average_rating")
    .joins(:reviews, :authors)
    .group(:authors_id)
    .order("average_rating DESC").limit(3)
  end

  def self.top_users
    select("reviews.user as users, count(reviews) as review_count")
    .joins(:reviews)
    .group(:users)
    .order("review_count desc NULLS LAST").limit(3)
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
