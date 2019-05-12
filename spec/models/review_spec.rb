require 'rails_helper'

RSpec.describe Review, type: :model do

  before :each do
    @author_1 = Author.create!(name: "Billy")
    @author_2 = Author.create!(name: "Logan")
    @book_1 = Book.create!(title: "Title 1", pages: 123, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_2 = Book.create!(title: "Title 2", pages: 223, published: 2002, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_3 = Book.create!(title: "Title 3", pages: 111, published: 2014, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_4 = Book.create!(title: "Title 4", pages: 121, published: 2016, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @author_1.books << [@book_1, @book_2, @book_4]
    @author_2.books << [@book_1, @book_3]
    @review_1 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 3, comment: "This is comment 1")
    @review_2 = @book_1.reviews.create!(title: "The best", user: "Billy U", rating: 4, comment: "This is comment 2")
    @review_3 = @book_2.reviews.create!(title: "Billy eats here", user: "Billy U", rating: 3, comment: "This is comment 3")
    @review_4 = @book_2.reviews.create!(title: "Avoid", user: "Logan P", rating: 1, comment: "This is comment 4")
    @review_5 = @book_3.reviews.create!(title: "Ok!", user: "Logan P", rating: 3, comment: "This is comment 5")
    @review_6 = @book_3.reviews.create!(title: "The best!", user: "Billy U", rating: 5, comment: "This is comment 6")
    @review_7 = @book_4.reviews.create!(title: "Yum", user: "Logan P", rating: 2, comment: "This is comment 7")
    @review_8 = @book_4.reviews.create!(title: "Avoid!", user: "Billy U", rating: 1, comment: "This is comment 8")
  end

  describe "validations" do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:user)}
    it {should validate_presence_of(:rating)}
    it {should validate_presence_of(:comment)}
  end

  describe 'relationships' do
    it {should belong_to(:book)}
  end

  describe 'class methods' do
    it ".sort_reviews" do
      expect(Review.sort_reviews("reviewsdesc")).to eq([@review_8, @review_7, @review_6, @review_5, @review_4, @review_3, @review_2, @review_1])
      expect(Review.sort_reviews("reviewsasc")).to eq([@review_1, @review_2, @review_3, @review_4, @review_5, @review_6, @review_7, @review_8])
    end
  end
end
