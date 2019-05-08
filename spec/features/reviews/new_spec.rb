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

          expect(current_path).to eq(review_path(new_review))
          expect(page).to have_content(title)
          expect(page).to have_content(user)
          expect(page).to have_content(rating)
          expect(page).to have_content(comment)
        end
      end
    end
  end
end
