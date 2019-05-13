require 'rails_helper'

RSpec.describe "Author's Show Page " do

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
    describe "when I visit a author's show page" do
      it "I see all books by author" do

        visit author_path(@author_1)

        within "#book-#{@book_1.id}" do
          expect(page).to have_content(@book_1.title)
          expect(page).to have_content(@book_1.pages)
          expect(page).to have_content(@book_1.published)
          expect(page).to have_css("img[src='#{@book_1.image}']")
          expect(page).to have_content("Co-authors: Logan")
        end

        within "#book-#{@book_7.id}" do
          expect(page).to have_content(@book_7.title)
          expect(page).to have_content(@book_7.pages)
          expect(page).to have_content(@book_7.published)
          expect(page).to have_css("img[src='#{@book_7.image}']")
          expect(page).to have_content("Co-authors: None")
        end
      end

      it "should show highest rated review" do

        visit author_path(@author_1)

        within "#book-#{@book_1.id}" do
          expect(page).to have_content(@review_2.title)
          expect(page).to have_content(@review_2.rating)
          expect(page).to have_content(@review_2.user)
        end

        within "#book-#{@book_2.id}" do
          expect(page).to have_content(@review_3.title)
          expect(page).to have_content(@review_3.rating)
          expect(page).to have_content(@review_3.user)
        end
      end

      describe "within each book section" do
        it "it should show a link to book show page" do

          visit author_path(@author_1)

          within "#book-#{@book_1.id}" do
            expect(page).to have_link(@book_1.title, href: book_path(@book_1))

            click_link @book_1.title

            expect(current_path).to eq(book_path(@book_1))
          end
        end
      end

      describe "within the highest review section" do
        it "it should show link to review title show page" do

          visit author_path(@author_1)

          within "#book-#{@book_1.id}" do
            expect(page).to have_link(@book_1.top_review.title, href: review_path(@book_1.top_review))

            click_link @book_1.top_review.title

            expect(current_path).to eq(review_path(@book_1.top_review))
          end
        end

        it "it should show link to review user show page" do

          visit author_path(@author_1)

          within "#book-#{@book_1.id}" do
            expect(page).to have_link(@book_1.top_review.user, href: user_path(@book_1.top_review.user))

            click_link @book_1.top_review.user

            expect(current_path).to eq(user_path(@book_1.top_review.user))
          end
        end
      end

      context "when there are no reviews" do
        before { Review.destroy_all }

        it "it will say no reviews next to title" do

          visit books_path

          within "#book-#{@book_1.id}" do
            expect(page).to have_content("No Reviews")
          end
        end
      end

      it "Theres a way to delete author" do

          visit author_path(@author_1)
          
          expect(page).to have_link("Delete Author", href: author_path(@author_1))

          click_link "Delete Author"

          expect(current_path).to eq(books_path(@book_1))
          expect(page).to have_content(@author_2.name)
          expect(page).to_not have_content(@author_1.name)
      end

    end
  end
end
