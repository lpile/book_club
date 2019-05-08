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
    @review_7 = @book_3.reviews.create!(title: "Yum", user: "Kyle C", rating: 2, comment: "This is comment 3")
    @review_8 = @book_4.reviews.create!(title: "Avoid!", user: "Todd", rating: 1, comment: "This is comment 4")
    @review_9 = @book_5.reviews.create!(title: "Ok...", user: "Billy U", rating: 3, comment: "This is comment 1")
    @review_10 = @book_7.reviews.create!(title: "The best!", user: "Jesse", rating: 5, comment: "This is comment 2")
    @review_11 = @book_8.reviews.create!(title: "Yummy", user: "Kyle C", rating: 3, comment: "This is comment 3")
    @review_12 = @book_8.reviews.create!(title: "Avoid!!", user: "Logan P", rating: 1, comment: "This is comment 4")
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

    it ".list_authors" do
      expect(@book_1.list_authors).to eq("Billy, Logan")
    end

    it ".co_authors" do
      expect(@book_1.co_authors(@author_1)).to eq("Logan")
    end
  end

  describe 'class methods' do
    it " can sort by average rating, page count, and number of reviews ascending and descending" do
      expect(Book.sort_books_by("pages", "DESC")).to eq([@book_7,@book_5,@book_2,@book_1,@book_4,@book_3,@book_6,@book_8])
      expect(Book.sort_books_by("pages","ASC")).to eq([@book_8,@book_6,@book_3,@book_4,@book_1,@book_2,@book_5,@book_7])

      expect(Book.sort_books_by("reviews","DESC")).to eq([@book_2,@book_1,@book_8,@book_3,@book_4,@book_5,@book_7,@book_6])
      expect(Book.sort_books_by("reviews","ASC")).to eq([@book_6,@book_7,@book_5,@book_4,@book_3,@book_8,@book_1,@book_2])

      expect(Book.sort_books_by("rated","DESC")).to eq([@book_8,@book_6,@book_3,@book_4,@book_1,@book_2,@book_5,@book_7])
      expect(Book.sort_books_by("rated","ASC")).to eq([@book_8,@book_6,@book_3,@book_4,@book_1,@book_2,@book_5,@book_7])

    end
  end

end
