require 'rails_helper'

RSpec.describe Book, type: :model do
  before :each do
    @author_1 = Author.create!(name: "Billy")
    @author_3 = Author.create!(name: "Thanos")
    @book_1 = @author_1.books.create!(title: "Title 1", pages: 123, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_2 = @author_1.books.create!(title: "Title 2", pages: 223, published: 2002, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @author_2 = @book_1.authors.create!(name: "Logan")
    @book_3 = @author_3.books.create!(title: "Title 3", pages: 111, published: 2014, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_4 = Book.create!(title: "Title 4", pages: 121, published: 2016, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_5 = Book.create!(title: "Title 5", pages: 321, published: 2010, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_6 = Book.create!(title: "Title 6", pages: 66, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_7 = Book.create!(title: "Title 7", pages: 444, published: 1966, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_8 = Book.create!(title: "Title 8", pages: 42, published: 2000, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @author_1.books << @book_4
    @author_2.books << @book_5
    @author_3.books << @book_6
    @author_1.books << @book_7
    @author_2.books << @book_8
    @author_3.books << @book_5
    @review_1 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 3, comment: "This is comment 1")
    @review_2 = @book_1.reviews.create!(title: "The best", user: "Billy U", rating: 4, comment: "This is comment 2")
    @review_3 = @book_2.reviews.create!(title: "Billy eats here", user: "Billy U", rating: 3, comment: "This is comment 3")
    @review_4 = @book_2.reviews.create!(title: "Avoid", user: "Logan P", rating: 1, comment: "This is comment 4")
    @review_5 = @book_2.reviews.create!(title: "Ok", user: "Sally", rating: 3, comment: "This is comment 1")
    @review_6 = @book_2.reviews.create!(title: "The best!", user: "Abbie", rating: 5, comment: "This is comment 2")
    @review_7 = @book_2.reviews.create!(title: "Yum", user: "Kyle C", rating: 2, comment: "This is comment 3")
    @review_8 = @book_3.reviews.create!(title: "Avoid!", user: "Todd", rating: 1, comment: "This is comment 4")
    @review_9 = @book_3.reviews.create!(title: "Ok...", user: "Billy U", rating: 3, comment: "This is comment 1")
    @review_10 = @book_3.reviews.create!(title: "The best!", user: "Jesse", rating: 5, comment: "This is comment 2")
    @review_11 = @book_3.reviews.create!(title: "Yummy", user: "Kyle C", rating: 3, comment: "This is comment 3")
    @review_12 = @book_4.reviews.create!(title: "Avoid!!", user: "Logan P", rating: 1, comment: "This is comment 4")
  end

  describe "validations" do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:pages)}
    it {should validate_presence_of(:published)}
    it {should validate_presence_of(:image)}
  end

  describe "relationships" do
    it {should have_many(:reviews)}
    it {should have_many(:authors).through(:author_books)}
  end

  describe 'instance methods' do
    it '.reviews_count' do
      expect(@book_1.reviews_count).to eq(2)
    end

    it '.rating_avg' do
      expect(@book_1.rating_avg).to eq(3.5)
    end

    it ".review_users" do
      expect(@book_1.review_users.join(", ")).to eq("Logan P, Billy U")
    end

    it ".list_authors" do
      expect(@book_1.list_authors.join(", ")).to eq("Billy, Logan")
    end

    it ".co_authors" do
      expect(@book_1.co_authors(@author_1).join(", ")).to eq("Logan")
    end

    it "should return highest review" do
      expect(@book_1.top_review).to eq(@review_2)
    end

    it "should return top 3 reviews" do
      review_3 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 4, comment: "This is comment 1")
      review_4 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 4, comment: "This is comment 1")
      review_5 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 3, comment: "This is comment 1")
      review_6 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 3, comment: "This is comment 1")
      review_7 = @book_1.reviews.create!(title: "meeh", user: "Logan P-dog", rating: 1, comment: "This is comment 1")
      review_8 = @book_1.reviews.create!(title: "meh", user: "Logan P-dawg", rating: 1, comment: "This is comment uno")
      review_9 = @book_1.reviews.create!(title: "meeeh", user: "Logan P-d", rating: 1, comment: "This is comment 1")

      expect(@book_1.top_3_reviews).to eq([@review_2,review_3, review_4])
    end

    it "should return bottom 3 reviews" do
      review_3 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 4, comment: "This is comment 1")
      review_4 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 4, comment: "This is comment 1")
      review_5 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 3, comment: "This is comment 1")
      review_6 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 3, comment: "This is comment 1")
      review_7 = @book_1.reviews.create!(title: "meeh", user: "Logan P-dog", rating: 1, comment: "This is comment 1")
      review_8 = @book_1.reviews.create!(title: "meh", user: "Logan P-dawg", rating: 1, comment: "This is comment uno")
      review_9 = @book_1.reviews.create!(title: "meeeh", user: "Logan P-d", rating: 1, comment: "This is comment 1")

      expect(@book_1.bottom_3_reviews).to eq([review_7,review_8, review_9])
    end

  end

  describe 'class methods' do
    it " can sort by average rating, page count, and number of reviews ascending and descending" do
      expect(Book.sort_books_by("pagesDESC")).to eq([@book_7,@book_5,@book_2,@book_1,@book_4,@book_3,@book_6,@book_8])
      expect(Book.sort_books_by("pagesASC")).to eq([@book_8,@book_6,@book_3,@book_4,@book_1,@book_2,@book_5,@book_7])

      expect(Book.sort_books_by("countsDESC")).to eq([@book_2,@book_3,@book_1,@book_4,@book_5,@book_6,@book_7,@book_8])
      expect(Book.sort_books_by("countsASC")).to eq([@book_5,@book_6,@book_7,@book_8,@book_4,@book_1,@book_3,@book_2])

      expect(Book.sort_books_by("ratedDESC")).to eq([@book_1,@book_3,@book_2,@book_4,@book_5,@book_6,@book_7,@book_8])
      expect(Book.sort_books_by("ratedASC")).to eq([@book_4,@book_2,@book_3,@book_1,@book_5,@book_6,@book_7,@book_8])

    end

    it "should return top 3 users who review" do
      review_3 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 4, comment: "This is comment 1")
      review_4 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 4, comment: "This is comment 1")
      review_5 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 3, comment: "This is comment 1")
      review_6 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 3, comment: "This is comment 1")

      expect(Book.top_users.first.users).to eq("Logan P")
      expect(Book.top_users.first.review_count).to eq(7)
      expect(Book.top_users[1].users).to eq("Billy U")
      expect(Book.top_users[1].review_count).to eq(3)
      expect(Book.top_users[2].users).to eq("Kyle C")
      expect(Book.top_users[2].review_count).to eq(2)
    end

    it "should return top 3 authors with highest average rating" do
      authors = Book.top_3_authors

      expect(authors.first.author_name).to eq("Logan")
      expect(authors.first.average_rating.round(2)).to eq(3.5)
      expect(authors[1].author_name).to eq("Thanos")
      expect(authors[1].average_rating.round(2)).to eq(3)
      expect(authors.last.author_name).to eq("Billy")
      expect(authors.last.average_rating.round(2)).to eq(2.75)

    end

  end

end
