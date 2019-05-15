require 'rails_helper'

RSpec.describe "Navigation Bar,", type: :feature do
  describe "As a visitor," do
    describe "I see a navigation bar" do
      it "on every page" do

        visit '/'

        within "#nav_1" do
          expect(page).to have_link("Home", href: '/')
          expect(page).to have_link("Books", href: books_path)
        end

        visit books_path

        within "#nav_1" do
          expect(page).to have_link("Home", href: '/')
          expect(page).to have_link("Books", href: books_path)
        end
      end

      describe "I click on the home's link" do
        it "goes to the window index page" do

          visit books_path

          click_link 'Home'

          expect(current_path).to eq('/')
        end
      end

      describe "I click on the book's link" do
        it "goes to the books index page" do

          visit '/'

          click_link 'Books'

          expect(current_path).to eq(books_path)
        end
      end
    end
  end
end
