require 'rails_helper'

RSpec.describe "Authors show page " do

  before :each do
    @author_1 = Author.create!(name: "Billy")
    @book_1 = @author_1.books.create!(title: "Title 1", pages: 123, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_2 = @author_1.books.create!(title: "Title 3", pages: 123, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @author_2 = @book_1.authors.create!(name: "Logan")
  end


    it "should show all books by author" do

      visit "/authors/#{@author_1.id}"

      expect(page).to have_content(@book_1.title)
      expect(page).to have_content(@book_2.title)

      within "#book-#{@book_1.id}" do
        expect(page).to have_content(@book_1.published)
        expect(page).to have_content(@book_1.pages)
        expect(page).to have_content(@author_2.name)
      end
      binding.pry
      within "#book-#{@book_2.id}" do
        expect(page).to have_content(@book_2.published)
        expect(page).to have_content(@book_2.pages)
        expect(page).to_not have_content(@book_2.authors.name)
      end



    end
end
