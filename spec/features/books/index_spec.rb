require "rails_helper"

RSpec.describe "books index page", type: :feature do
  before :each do
    @book_1 = Book.create!(title: "Title 1", pages: 123, authors: "Author 1", published: 1999, image: "image_1.jpg")
    @book_2 = Book.create!(title: "Title 2", pages: 221, authors: "Author 2", published: 2010, image: "image_2.jpg")
  end
  describe "As a visitor" do
    describe "when I visit a book index page" do
      it "I see all book titles in the database" do
        visit '/books'

        within '#books' do
          expect(page).to have_content(@book_1.title)
          expect(page).to have_content(@book_2.title)
        end

      end

      it "I see links to book show pages" do
        visit '/books'

        expect(page).to have_link(@book_1.title)

        click_link @book_1.title

        within '#book_show' do
          expect(current_path).to eq("/books/#{@book_1.id}")
          expect(page).to have_content(@book_1.title)
          expect(page).to_not have_content(@book_2.title)
        end
      end
    end

  end
end
