require 'rails_helper'

RSpec.describe "Welcome page" do
    describe " Nav bar links" do
      it "lead to correct pages" do
        visit '/'
        expect(current_path).to eq('/')

        within "#nav_1" do
          expect(page).to have_link('Home')
          expect(page).to have_link('Books')
        end


        click_link 'Books'
      
        expect(current_path).to eq('/books')
      end
    end
end
