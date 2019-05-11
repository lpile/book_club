require "rails_helper"

RSpec.describe "Reviews New Page", type: :feature do
  describe "A visitor creates a new review" do
    describe "they link from the books show" do
      describe "they fill in information" do
        it "creates a new review" do
          new_book = Book.create!(title: "Title 1", pages: 123, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")
          title = "New Review!"
          user = "New User!"
          rating = 5
          comment = "New Comment!"

          visit new_book_review_path(new_book)

          fill_in 'Title', with: title
          fill_in 'User', with: user
          fill_in 'Rating', with: rating
          fill_in 'Comment', with: comment

          click_on 'Create Review'

          new_review = Review.last

          expect(current_path).to eq(book_path(new_book))
          expect(page).to have_content(new_review.title)
          expect(page).to have_content(new_review.user)
          expect(page).to have_content(new_review.rating)
          expect(page).to have_content(new_review.comment)
        end
      end
      context "and correct information is filled" do
        it "so reviews title and user are title case" do
          new_book = Book.create!(title: "Title 1", pages: 123, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")

          visit new_book_review_path(new_book)

          fill_in 'Title', with: "first review"
          fill_in 'User', with: "logan"
          fill_in 'Rating', with: 3
          fill_in 'Comment', with: 'test comment 1'

          click_on 'Create Review'

          review_1 = Review.last

          expect(review_1.title).to eq("First Review")
          expect(review_1.user).to eq("Logan")
        end

        it "so user cannot have two reviews on same book" do
          new_book = Book.create!(title: "Title 1", pages: 123, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")
          review_1 = new_book.reviews.create(title: "First Review", user: "Logan", rating: 3, comment: "Test comment 2")

          visit new_book_review_path(new_book)

          fill_in 'Title', with: "second review"
          fill_in 'User', with: "logan"
          fill_in 'Rating', with: 3
          fill_in 'Comment', with: 'test comment 2'

          click_on 'Create Review'

          test_review = Review.last

          expect(review_1).to eq(test_review)
        end
      end
    end
  end
end
