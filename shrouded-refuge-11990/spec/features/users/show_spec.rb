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
    @review_1 = @book_1.reviews.create!(title: "Review 1", user: "Logan P", rating: 1, comment: "This is comment 1")
    @review_2 = @book_1.reviews.create!(title: "Review 2", user: "Billy U", rating: 1, comment: "This is comment 2")
    @review_3 = @book_2.reviews.create!(title: "Review 3", user: "Billy U", rating: 1, comment: "This is comment 3")
    @review_4 = @book_2.reviews.create!(title: "Review 4", user: "Logan P", rating: 1, comment: "This is comment 4")
    @review_5 = @book_3.reviews.create!(title: "Review 5", user: "Logan P", rating: 5, comment: "This is comment 5")
    @review_6 = @book_3.reviews.create!(title: "Review 6", user: "Billy U", rating: 5, comment: "This is comment 6")
    @review_7 = @book_4.reviews.create!(title: "Review 7", user: "Logan P", rating: 5, comment: "This is comment 7")
    @review_8 = @book_4.reviews.create!(title: "Review 8", user: "Billy U", rating: 5, comment: "This is comment 8")
    @user = @review_4.user
  end

  describe "As a visitor" do
    describe "when I visit a user's show page" do
      it "the user's information is displayed" do

        visit user_path(@user)

        within("#user-#{@review_1.id}") do
          expect(page).to have_content(@review_1.title)
          expect(page).to have_content(@review_1.rating)
          expect(page).to have_content(@review_1.comment)
          expect(page).to have_content(@review_1.book.title)
          expect(page).to have_css("img[src='#{@review_1.book.image}']")
        end

        within("#user-#{@review_4.id}") do
          expect(page).to have_content(@review_4.title)
          expect(page).to have_content(@review_4.rating)
          expect(page).to have_content(@review_4.comment)
          expect(page).to have_content(@review_4.book.title)
          expect(page).to have_css("img[src='#{@review_4.book.image}']")
        end
      end

      it "there's a link to review's show page" do
        visit user_path(@user)

        within("#user-#{@review_1.id}") do
          expect(page).to have_link(@review_1.title, href: review_path(@review_1))

          click_link @review_1.title

          expect(current_path).to eq(review_path(@review_1))
        end
      end

      it "there's a link to book's show page" do
        visit user_path(@user)

        within("#user-#{@review_1.id}") do
          expect(page).to have_link(@review_1.book.title, href: book_path(@review_1.book))

          click_link @review_1.book.title

          expect(current_path).to eq(book_path(@review_1.book))
        end
      end

      it "there's a way to delete review" do

        visit user_path(@user)

        within("#user-#{@review_1.id}") do
          expect(page).to have_link("Delete", href: user_path(@user, rev_id: @review_1.id))
          click_link "Delete"
        end

        expect(current_path).to eq(user_path(@user))
        expect(@book_1.reviews.include?(@review_1)).to eq(false)
      end

      it "there's a way to sort newest reviews first" do

        visit user_path(@user)

        expect(page).to have_link("Newest Reviews", href: user_path(@user, table: "reviewsasc"))

        click_link "Newest Reviews"

        expect(@review_1.title).to appear_before(@review_4.title)
        expect(@review_4.title).to appear_before(@review_5.title)
        expect(@review_5.title).to appear_before(@review_7.title)
      end

      it "there's a way to sort oldest reviews first" do

        visit user_path(@user)

        expect(page).to have_link("Oldest Reviews", href: user_path(@user, table: "reviewsdesc"))

        click_link "Oldest Reviews"

        expect(@review_7.title).to appear_before(@review_5.title)
        expect(@review_5.title).to appear_before(@review_4.title)
        expect(@review_4.title).to appear_before(@review_1.title)
      end

      it "there's a way to sort highest reviews ratings" do

        visit user_path(@user)

        expect(page).to have_link("Highest Rated Reviews", href: user_path(@user, table: "ratingsdesc"))

        click_link "Highest Rated Reviews"

        expect(@review_7.title).to appear_before(@review_5.title)
        expect(@review_5.title).to appear_before(@review_4.title)
        expect(@review_4.title).to appear_before(@review_1.title)
      end

      it "there's a way to sort lowest reviews ratings" do

        visit user_path(@user)

        expect(page).to have_link("Lowest Rated Reviews", href: user_path(@user, table: "ratingsasc"))

        click_link "Lowest Rated Reviews"

        expect(@review_1.title).to appear_before(@review_4.title)
        expect(@review_4.title).to appear_before(@review_5.title)
        expect(@review_5.title).to appear_before(@review_7.title)
      end
    end
  end
end
