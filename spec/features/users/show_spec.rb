require "rails_helper"

RSpec.describe "User's Show Page,", type: :feature do

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
    @review_5 = @book_3.reviews.create!(title: "Ok", user: "Logan P", rating: 3, comment: "This is comment 5")
    @review_6 = @book_3.reviews.create!(title: "The best!", user: "Billy U", rating: 5, comment: "This is comment 6")
    @review_7 = @book_4.reviews.create!(title: "Yum", user: "Logan P", rating: 2, comment: "This is comment 7")
    @review_8 = @book_4.reviews.create!(title: "Avoid!", user: "Billy U", rating: 1, comment: "This is comment 8")
  end

  describe "As a visitor" do
    describe "when I visit a user's show page" do
      it "the user's information is displayed" do

        visit user_path(@review_1.user)

        within("#user-#{@review_1.id}") do
          expect(page).to have_link(@review_1.title, href: review_path(@review_1))
          expect(page).to have_content(@review_1.rating)
          expect(page).to have_content(@review_1.comment)
          expect(page).to have_link(@review_1.book.title, href: book_path(@review_1.book))
          expect(page).to have_css("img[src='#{@review_1.book.image}']")
        end

        within("#user-#{@review_4.id}") do
          expect(page).to have_link(@review_4.title, href: review_path(@review_4))
          expect(page).to have_content(@review_4.rating)
          expect(page).to have_content(@review_4.comment)
          expect(page).to have_link(@review_4.book.title, href: book_path(@review_4.book))
          expect(page).to have_css("img[src='#{@review_4.book.image}']")
        end
      end
    end
  end
end
