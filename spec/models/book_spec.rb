require 'rails_helper'

RSpec.describe Book, type: :model do
  before :each do
    @book_1 = Book.create!(title: "Title 1", pages: 123, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_2 = Book.create!(title: "Title 2", pages: 221, published: 2010, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @review_1 = @book_1.reviews.create(title: "Ok", user: "Logan P", rating: 3, comment: "This is comment 1")
    @review_2 = @book_1.reviews.create(title: "The best", user: "Bob", rating: 4, comment: "This is comment 2")
    @review_3 = @book_2.reviews.create(title: "Billy eats here", user: "Billy U", rating: 3, comment: "This is comment 3")
    @review_4 = @book_2.reviews.create(title: "Avoid", user: "Ted", rating: 4, comment: "This is comment 4")
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
  end
end
