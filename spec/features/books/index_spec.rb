require "rails_helper"

RSpec.describe "Book's Index Page,", type: :feature do

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

  describe "As a visitor," do
    it "I see links to sort the books" do

      visit books_path

      expect(page).to have_link("Most Pages", href:"/books?sort=pagesDESC")
      expect(page).to have_link("Least Pages", href:"/books?table=pagesASC")
      expect(page).to have_link("Most Reviews", href:"/books?table=countsDESC")
      expect(page).to have_link("Least Reviews", href:"/books?table=countsASC")
      expect(page).to have_link("Highest Rated", href:"/books?table=ratedDESC")
      expect(page).to have_link("Least Rated", href:"/books?table=ratedASC")
    end

    it "I see all book titles in the database" do

      visit books_path

      within("#book-#{@book_1.id}") do

        expect(page).to have_content("Author(s): #{@book_1.list_authors.join(", ")}")
        expect(page).to have_content("Pages: #{@book_1.pages}")
        expect(page).to have_content("Published: #{@book_1.published}")
        expect(page).to have_css("img[src='#{@book_1.image}']")
        expect(page).to_not have_content(@book_2.title)
      end

      within("#book-#{@book_2.id}") do
        expect(page).to have_link(@book_2.title, href: book_path(@book_2))
        expect(page).to have_content("Author(s): #{@book_2.list_authors.join(", ")}")
        expect(page).to have_content("Pages: #{@book_2.pages}")
        expect(page).to have_content("Published: #{@book_2.published}")
        expect(page).to have_css("img[src='#{@book_2.image}']")
        expect(page).to_not have_content(@book_1.title)
      end
    end

    describe "next to each book title," do
      it "I see it's average book rating" do

        visit books_path

        within("#book-#{@book_1.id}") do
          expect(page).to have_content("#{@book_1.title} Rating: #{@book_1.rating_avg}")
        end

        within("#book-#{@book_2.id}") do
          expect(page).to have_content("#{@book_2.title} Rating: #{@book_2.rating_avg}")
        end
      end

      it "I see the total number of reviews for the book" do

        visit books_path

        within("#book-#{@book_1.id}") do
          expect(page).to have_content("#{@book_1.title} Rating: #{@book_1.rating_avg} Reviews: #{@book_1.reviews_count}")
        end

        within("#book-#{@book_2.id}") do
          expect(page).to have_content("#{@book_2.title} Rating: #{@book_2.rating_avg} Reviews: #{@book_2.reviews_count}")
        end
      end

      it "there's a link to the book's show page" do

        visit books_path

        within("#book-#{@book_1.id}") do
          expect(page).to have_link(@book_1.title, href: book_path(@book_1))

          click_link  @book_1.title

          expect(current_path).to eq(book_path(@book_1))
        end
      end

      context "when there are no reviews" do
        before { Review.destroy_all }

        it "it will say no reviews next to title" do

          visit books_path

          within("#book-#{@book_1.id}") do
            expect(page).to have_content("#{@book_1.title} No Reviews")
          end
        end
      end
    end

    describe "I click on the book's title" do
      it "it sends me to the book's show page" do

        visit books_path

        expect(page).to have_link(@book_1.title, href: book_path(@book_1))

        click_link @book_1.title

        expect(current_path).to eq(book_path(@book_1))
        expect(page).to have_content(@book_1.title)
        expect(page).to_not have_content(@book_2.title)
      end
    end

    describe "at the bottom," do
      it "theres a way to add new book" do

        visit books_path

        expect(page).to have_link("Create a New Book", href: new_book_path)

        click_link "Create a New Book"

        fill_in "Title:", with: "New Title"
        fill_in "Number of Pages:", with: 222
        fill_in "Year Published:", with: 1999
        fill_in "Author(s):", with: "New Author"
        fill_in "Cover Image:", with: "http://clipart-library.com/images/6cr5yaAqi.png"

        click_on 'Create Book'

        expect(current_path).to eq(books_path)
        expect(page).to have_content("New Title")
      end

      context "the correct information will be stored" do

        before do
          visit new_book_path

          fill_in "Title:", with: "test title"
          fill_in "Author(s):", with: "logan pile, billy urrutia"
          fill_in "Number of Pages:", with: 222
          fill_in "Year Published:", with: 1999

          click_on 'Create Book'
        end

        it "so the title will be title case" do

          expect(Book.last.title).to eq("Test Title")
        end

        it "so it will split co-authors and name will be title case" do
          expect(Book.last.list_authors.join(", ")).to eq("Logan Pile, Billy Urrutia")
        end

        it "so there will be unique book titles" do
          book = Book.create(title: "Test Title", pages: 222, published: 1999, image: "http://clipart-library.com/images/6cr5yaAqi.png")

          expect(book.valid?).to eq(false)
        end

        it "so there would be unique author names" do
          author_1 = Author.create(name: "Logan Pile")
          author_2 = Author.create(name: "Billy Urrutia")

          expect(author_1.valid?).to eq(false)
          expect(author_2.valid?).to eq(false)
        end

        it "so there would be unique books" do
          visit new_book_path

          fill_in "Title:", with: "test title"
          fill_in "Author(s):", with: "logan pile, billy urrutia"
          fill_in "Number of Pages:", with: 222
          fill_in "Year Published:", with: 1999

          click_on 'Create Book'

          expect(current_path).to eq(new_book_path)
        end

        it "so there is no image enter, it shows default" do
          expect(Book.last.image).to eq("http://clipart-library.com/images/6cr5yaAqi.png")
        end
      end
    end

    context "when there are no books" do
      before { Book.destroy_all }

      it "it will notify me there are no books" do

        visit books_path

        expect(page).to have_content("There are no books. Please add one.")
      end

      it "there's a link to add book" do

        visit books_path

        expect(page).to have_link("Create a New Book", href: new_book_path)
      end
    end

      it "should see statistics with top 3 highest rated books" do

          visit books_path

          array_of_correct_books = [@book_1, @book_4, @book_7]

          within ".statistics" do
            array_of_correct_books. each do |book|
              expect(page).to have_content(book.title)
              expect(page).to have_content(book.rating_avg)
            end
          end
      end

      it "should see statistics 3 lowest ratings" do

          visit books_path

          array_of_correct_books = [@book_5,@book_8,@book_2]

          within ".statistics" do
            array_of_correct_books. each do |book|
              expect(page).to have_content(book.title)
              expect(page).to have_content(book.rating_avg)
            end
          end

      end

      it "should return users with the highest number of reviews and their counts" do

        visit books_path

        within ".statistics" do
          expect(page).to have_content("User name: Logan P")
          expect(page).to have_content("Review count: 3")
          expect(page).to have_content("User name: Billy U")
          expect(page).to have_content("Review count: 3")
          expect(page).to have_content("User name: Kyle C")
          expect(page).to have_content("Review count: 2")
        end
      end

      context "when there are no reviews" do
        before { Review.destroy_all }

        it "wonder what happens with books and no reviews" do

          visit books_path

          within ".statistics" do
            expect(page).to have_content("Average Rating: 0")
          end
        end
      end




    end

  end
