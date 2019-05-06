require 'rails_helper'

RSpec.describe "Welcome page",type: :view do
    describe " Nav bar links" do
      it "lead to correct pages" do

        # expect(current_path).to eq('/')

        within "#nav_1" do
          page.should have_link('Home')
          page.should have_link('Books')
        end


        # click_link 'Books'
      #
      #   expect(current_path).to eq('/books')
      # end
    end
end
end
