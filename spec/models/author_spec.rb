require "rails_helper"

RSpec.describe Author, type: :model do
  describe "validations" do
    it {should validate_presence_of(:name)}
  end

  describe "relationships" do
    it {should have_many(:author_books)}
    it {should have_many(:books).through(:author_books)}
  end

  describe "class method" do
    it "should return top 3 authors with highest average rating" do
      author_1 = Author.create!(name: "Billy")
      author_3 = Author.create!(name: "Thanos")
      book_1 = author_1.books.create!(title: "Title 1", pages: 123, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")
      book_2 = author_1.books.create!(title: "Title 2", pages: 223, published: 2002, image: "http://clipart-library.com/images/6cr5yaAqi.png")
      author_2 = book_1.authors.create!(name: "Logan")
      book_3 = author_3.books.create!(title: "Title 3", pages: 111, published: 2014, image: "http://clipart-library.com/images/6cr5yaAqi.png")
      book_4 = Book.create!(title: "Title 4", pages: 121, published: 2016, image: "http://clipart-library.com/images/6cr5yaAqi.png")
      book_5 = Book.create!(title: "Title 5", pages: 321, published: 2010, image: "http://clipart-library.com/images/6cr5yaAqi.png")
      book_6 = Book.create!(title: "Title 6", pages: 66, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")
      book_7 = Book.create!(title: "Title 7", pages: 444, published: 1966, image: "http://clipart-library.com/images/6cr5yaAqi.png")
      book_8 = Book.create!(title: "Title 8", pages: 42, published: 2000, image: "http://clipart-library.com/images/6cr5yaAqi.png")
      author_1.books << book_4
      author_2.books << book_5
      author_3.books << book_6
      author_1.books << book_7
      author_2.books << book_8
      author_3.books << book_5
      review_1 = book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 3, comment: "This is comment 1")
      review_2 = book_1.reviews.create!(title: "The best", user: "Billy U", rating: 4, comment: "This is comment 2")
      review_3 = book_2.reviews.create!(title: "Billy eats here", user: "Billy U", rating: 3, comment: "This is comment 3")
      review_4 = book_2.reviews.create!(title: "Avoid", user: "Logan P", rating: 1, comment: "This is comment 4")
      review_5 = book_2.reviews.create!(title: "Ok", user: "Sally", rating: 3, comment: "This is comment 1")
      review_6 = book_2.reviews.create!(title: "The best!", user: "Abbie", rating: 5, comment: "This is comment 2")
      review_7 = book_2.reviews.create!(title: "Yum", user: "Kyle C", rating: 2, comment: "This is comment 3")
      review_8 = book_3.reviews.create!(title: "Avoid!", user: "Todd", rating: 1, comment: "This is comment 4")
      review_9 = book_3.reviews.create!(title: "Ok...", user: "Billy U", rating: 3, comment: "This is comment 1")
      review_10 = book_3.reviews.create!(title: "The best!", user: "Jesse", rating: 5, comment: "This is comment 2")
      review_11 = book_3.reviews.create!(title: "Yummy", user: "Kyle C", rating: 3, comment: "This is comment 3")
      review_12 = book_4.reviews.create!(title: "Avoid!!", user: "Logan P", rating: 1, comment: "This is comment 4")


      authors = Author.top_3_authors

      expect(authors.first.name).to eq("Logan")
      expect(authors.first.average_rating.round(2)).to eq(3.5)
      expect(authors[1].name).to eq("Thanos")
      expect(authors[1].average_rating.round(2)).to eq(3)
      expect(authors.last.name).to eq("Billy")
      expect(authors.last.average_rating.round(2)).to eq(2.75)

    end

  end
end
