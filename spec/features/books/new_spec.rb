require "rails_helper"

RSpec.describe "Books New Page", type: :feature do
  describe "A visitor creates a new book" do
    describe "they link from the books index" do
      describe "they fill in information" do
        it "creates a new book" do
          new_book = Book.create!(title: "Title 1", pages: 123, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")

          visit new_book_path

          fill_in 'Title', with: new_book.title
          fill_in 'Pages', with: new_book.pages
          fill_in 'Published', with: new_book.published
          fill_in 'Image', with: new_book.image
          click_on 'Create Book'

          expect(current_path).to eq("/books")
          expect(page).to have_content(new_book.title)
          expect(page).to have_content(new_book.pages)
          expect(page).to have_content(new_book.published)
          expect(page).to have_css("img[src='#{new_book.image}']")
        end
      end
    end
  end
end
