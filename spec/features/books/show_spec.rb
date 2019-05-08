require "rails_helper"

RSpec.describe "Books Show Page,", type: :feature do
  before :each do
    @author_1 = Author.create!(name: "Billy")
    @author_3 = Author.create!(name: "Thanos")
    @book_1 = @author_1.books.create!(title: "Title 1", pages: 123, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_2 = @author_1.books.create!(title: "Title 2", pages: 223, published: 2002, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @author_2 = @book_1.authors.create!(name: "Logan")
    @book_3 = @author_3.books.create!(title: "Title 3", pages: 111, published: 2014, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_4 = Book.create!(title: "Title 4", pages: 121, published: 2016, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_5 = Book.create!(title: "Title 5", pages: 321, published: 2010, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_6 = Book.create!(title: "Title 6", pages: 66, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_7 = Book.create!(title: "Title 7", pages: 444, published: 1966, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_8 = Book.create!(title: "Title 8", pages: 42, published: 2000, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @author_1.books << @book_4
    @author_2.books << @book_5
    @author_3.books << @book_6
    @author_1.books << @book_7
    @author_2.books << @book_8
    @author_3.books << @book_5
    @review_1 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 3, comment: "This is comment 1")
    @review_2 = @book_1.reviews.create!(title: "The best", user: "Billy U", rating: 4, comment: "This is comment 2")
    @review_3 = @book_2.reviews.create!(title: "Billy eats here", user: "Billy U", rating: 3, comment: "This is comment 3")
    @review_4 = @book_2.reviews.create!(title: "Avoid", user: "Logan P", rating: 1, comment: "This is comment 4")
    @review_5 = @book_3.reviews.create!(title: "Ok", user: "Sally", rating: 3, comment: "This is comment 1")
    @review_6 = @book_4.reviews.create!(title: "The best!", user: "Abbie", rating: 5, comment: "This is comment 2")
    @review_7 = @book_5.reviews.create!(title: "Yum", user: "Kyle C", rating: 2, comment: "This is comment 3")
    @review_8 = @book_5.reviews.create!(title: "Avoid!", user: "Todd", rating: 1, comment: "This is comment 4")
    @review_9 = @book_6.reviews.create!(title: "Ok...", user: "Billy U", rating: 3, comment: "This is comment 1")
    @review_10 = @book_7.reviews.create!(title: "The best!", user: "Jesse", rating: 5, comment: "This is comment 2")
    @review_11 = @book_8.reviews.create!(title: "Yummy", user: "Kyle C", rating: 3, comment: "This is comment 3")
    @review_12 = @book_8.reviews.create!(title: "Avoid!!", user: "Logan P", rating: 1, comment: "This is comment 4")
  end

  describe "As a visitor" do
    describe "when I visit a book show page" do
      it "theres a link to delete book" do
        visit book_path(@book_1)

        expect(page).to have_link("Delete")
        
        click_link "Delete"

        expect(current_path).to eq(books_path)
        expect(page).to have_content(@book_2.title)
        expect(page).to_not have_content(@book_1.title)
        expect(@author_1.books).to_not have_content(@book_1.title)
      end

      it "theres a link to edit book" do
        edit_book = Book.create!(title: "New Title", pages: 444, published: 2018, image: "http://clipart-library.com/images/6cr5yaAqi.png")

        visit book_path(@book_1)

        expect(page).to have_link("Edit")

        click_link "Edit"

        fill_in 'Title', with: edit_book.title
        fill_in 'Pages', with: edit_book.pages
        fill_in 'Published', with: edit_book.published
        fill_in 'Image', with: edit_book.image
        click_on "Update Book"

        expect(current_path).to eq(book_path(@book_1))
        expect(page).to have_content(edit_book.title)
        expect(page).to have_content(edit_book.pages)
        expect(page).to have_content(edit_book.published)
        expect(page).to have_css("img[src='#{edit_book.image}']")
      end
    end
  end
end
