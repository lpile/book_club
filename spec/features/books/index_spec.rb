require "rails_helper"

RSpec.describe "Books Index Page,", type: :feature do
  before :each do
    @author_1 = Author.create!(name: "Logan")
    @author_2 = Author.create!(name: "Billy")
    @book_1 = Book.create!(title: "Title 1", pages: 123, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_2 = Book.create!(title: "Title 2", pages: 221, published: 2010, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @review_1 = @book_1.reviews.create(title: "Ok", user: "Logan P", rating: 3, comment: "This is comment 1")
    @review_2 = @book_1.reviews.create(title: "The best", user: "Bob", rating: 4, comment: "This is comment 2")
    @review_3 = @book_2.reviews.create(title: "Billy eats here", user: "Billy U", rating: 3, comment: "This is comment 3")
    @review_4 = @book_2.reviews.create(title: "Avoid", user: "Ted", rating: 1, comment: "This is comment 4")
    @authorbook_1 = AuthorBook.create!(author_id: @author_2.id, book_id: @book_1.id)
    @authorbook_2 = AuthorBook.create!(author_id: @author_1.id, book_id: @book_2.id)
  end

  describe "As a visitor" do
    describe "when I visit a book index page" do
      it "I see all book titles in the database" do
        visit '/books'

        within("#book-#{@book_1.id}") do
          expect(page).to have_link(@book_1.title)
          expect(page).to have_content(@book_1.title)
          expect(page).to_not have_content(@book_2.title)
          expect(page).to have_css("img[src='#{@book_1.image}']")
        end

        within("#book-#{@book_2.id}") do
          expect(page).to have_link(@book_2.title)
          expect(page).to have_content(@book_2.title)
          expect(page).to_not have_content(@book_1.title)
          expect(page).to have_css("img[src='#{@book_2.image}']")
        end
      end

      it "I see links to book show pages" do
        visit '/books'

        expect(page).to have_link(@book_1.title)

        click_link @book_1.title

        expect(current_path).to eq("/books/#{@book_1.id}")
        expect(page).to have_content(@book_1.title)
        expect(page).to_not have_content(@book_2.title)
      end

      it "next to each book title, I see its average book rating and number of reviews" do
        visit '/books'

        within("#book-#{@book_1.id}") do
          expect(page).to have_content("Rating: #{@book_1.rating_avg}")
          expect(page).to have_content("Reviews: #{@book_1.reviews_count}")
        end
      end
    end
  end
end
