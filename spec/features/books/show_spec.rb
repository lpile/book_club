require "rails_helper"

RSpec.describe "books show page", type: :feature do
  before :each do
    @book_1 = Book.create!(title: "Title 1", pages: 123, authors: "Author 1", published: 1999, image: "image_1.jpg")
    @book_2 = Book.create!(title: "Title 2", pages: 221, authors: "Author 2", published: 2010, image: "image_2.jpg")
    @review_1 = @book_1.reviews.create(title: "Ok", user: "Logan P", rating: 3, comment: "This is comment 1")
    @review_2 = @book_1.reviews.create(title: "The best", user: "Bob", rating: 3, comment: "This is comment 2")
    @review_3 = @book_2.reviews.create(title: "Billy eats here", user: "Billy U", rating: 3, comment: "This is comment 3")
    @review_4 = @book_2.reviews.create(title: "Avoid", user: "Ted", rating: 3, comment: "This is comment 4")
  end

  describe "As a visitor" do
    describe "when I visit a book's show page" do
      it "I see all book's information'" do

        visit "/books/#{@book_1.id}"

        expect(page).to have_content(@book_1.title)
        expect(page).to have_content(@book_1.pages)
        expect(page).to_not have_content(@book_2.title)
      end
    end
  end
end
