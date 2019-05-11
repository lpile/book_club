require "rails_helper"

RSpec.describe "Book's Show Page,", type: :feature do

  before :each do
    @author_1 = Author.create!(name: "Billy")
    @author_2 = Author.create!(name: "Logan")
    @author_3 = Author.create!(name: "Thanos")
    @book_1 = Book.create!(title: "Title 1", pages: 123, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_2 = Book.create!(title: "Title 2", pages: 223, published: 2002, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_3 = Book.create!(title: "Title 3", pages: 111, published: 2014, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_4 = Book.create!(title: "Title 4", pages: 121, published: 2016, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_5 = Book.create!(title: "Title 5", pages: 321, published: 2010, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_6 = Book.create!(title: "Title 6", pages: 66, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_7 = Book.create!(title: "Title 7", pages: 444, published: 1966, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @book_8 = Book.create!(title: "Title 8", pages: 42, published: 2000, image: "http://clipart-library.com/images/6cr5yaAqi.png")
    @author_1.books << [@book_1, @book_2, @book_4, @book_7]
    @author_2.books << [@book_1, @book_5, @book_8]
    @author_3.books << [@book_3, @book_5, @book_6]
    @review_1 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 3, comment: "This is comment 1")
    @review_2 = @book_1.reviews.create!(title: "The best", user: "Billy U", rating: 4, comment: "This is comment 2")
    @review_3 = @book_2.reviews.create!(title: "Billy eats here", user: "Billy U", rating: 3, comment: "This is comment 3")
    @review_4 = @book_2.reviews.create!(title: "Avoid", user: "Logan P", rating: 1, comment: "This is comment 4")
    @review_5 = @book_3.reviews.create!(title: "Ok", user: "Sally", rating: 3, comment: "This is comment 5")
    @review_6 = @book_4.reviews.create!(title: "The best!", user: "Abbie", rating: 5, comment: "This is comment 6")
    @review_7 = @book_5.reviews.create!(title: "Yum", user: "Kyle C", rating: 2, comment: "This is comment 7")
    @review_8 = @book_5.reviews.create!(title: "Avoid!", user: "Todd", rating: 1, comment: "This is comment 8")
    @review_9 = @book_6.reviews.create!(title: "Ok...", user: "Billy U", rating: 3, comment: "This is comment 9")
    @review_10 = @book_7.reviews.create!(title: "The best!", user: "Jesse", rating: 5, comment: "This is comment 10")
    @review_11 = @book_8.reviews.create!(title: "Yummy", user: "Kyle C", rating: 3, comment: "This is comment 11")
    @review_12 = @book_8.reviews.create!(title: "Avoid!!", user: "Logan P", rating: 1, comment: "This is comment 12")
  end

  describe "As a visitor" do
    describe "when I visit a book's show page" do
      it "the book's information is displayed" do

        visit book_path(@book_1)

        expect(page).to have_content(@book_1.title)
        expect(page).to have_content(@book_1.authors.name)
        expect(page).to have_content(@book_1.pages)
        expect(page).to have_content(@book_1.published)
        expect(page).to have_css("img[src='#{@book_1.image}']")
        expect(page).to_not have_content(@book_2.title)
      end

      it "the book's reviews are displayed" do

        visit book_path(@book_1)

        within("#subsection") do
          expect(page).to have_content(@review_1.title)
          expect(page).to have_content(@review_2.title)
          expect(page).to_not have_content(@review_3.title)
        end
      end

      describe "should have review statistics area" do
        before do
          @review_1 = @book_1.reviews.create!(title: "Ok", user: "Logan P", rating: 3, comment: "This is comment 1")
          @review_2 = @book_1.reviews.create!(title: "Very Good", user: "Billy U", rating: 4, comment: "This is comment 2")
          @review_3 = @book_1.reviews.create!(title: "Billy eats here", user: "Billy U", rating: 3, comment: "This is comment 3")
          @review_4 = @book_1.reviews.create!(title: "Avoid", user: "Logan P", rating: 1, comment: "This is comment 4")
          @review_5 = @book_1.reviews.create!(title: "Ok", user: "Sally", rating: 3, comment: "This is comment 5")
          @review_6 = @book_1.reviews.create!(title: "The best!!!", user: "Abbie", rating: 5, comment: "This is comment 6")
          @review_7 = @book_1.reviews.create!(title: "Yum", user: "Kyle C", rating: 2, comment: "This is comment 7")
          @review_8 = @book_1.reviews.create!(title: "Don't Go!", user: "Todd", rating: 2, comment: "This is comment 8")
          @review_9 = @book_1.reviews.create!(title: "Ok...", user: "Billy U", rating: 3, comment: "This is comment 9")
          @review_10 = @book_1.reviews.create!(title: "The best!", user: "Jesse", rating: 5, comment: "This is comment 10")
          @review_11 = @book_1.reviews.create!(title: "Yummy", user: "Kyle C", rating: 3, comment: "This is comment 11")
          @review_12 = @book_1.reviews.create!(title: "Avoid!!", user: "Logan P", rating: 1, comment: "This is comment 12")
        end

        it "where it shows average rating from book's reviews" do

          visit book_path(@book_1)

          within ".statistics" do
            expect(page).to have_content("Rating: #{@book_1.rating_avg.round(1)}")
          end
        end

        it "where it shows top 3 reviews from book's reviews" do

          visit book_path(@book_1)

          within ".statistics" do
            expect(@review_6.title).to appear_before(@review_2.title)
            expect(@review_10.title).to appear_before(@review_2.title)
          end
        end

        it "where it shows bottom 3 reviews from book's reviews" do

          visit book_path(@book_1)

          within ".statistics" do
            expect(@review_6.title).to appear_before(@review_7.title)
            expect(@review_10.title).to appear_before(@review_7.title)
          end
        end
      end

      it "theres a way to delete book" do

        visit book_path(@book_1)

        expect(page).to have_link("Delete Book", href: book_path(@book_1))

        click_link "Delete Book"

        expect(current_path).to eq(books_path)
        expect(page).to have_content(@book_2.title)
        expect(page).to_not have_content(@book_1.title)
        expect(@author_1.books).to_not have_content(@book_1.title)
      end

      it "theres a link to edit book" do

        visit book_path(@book_1)

        expect(page).to have_link("Edit Book", href: edit_book_path(@book_1))
      end
    end
  end
end
