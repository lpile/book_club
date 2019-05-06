require 'rails_helper'

RSpec.describe "Nav_bar" do

  describe "Nav bar leads to home and /books" do
    visit '/'

    within "nav" do
      expect(page).to have_link("Home")
      expect(page).to have_link("Books")
    end

    click_link "Home"

    expect(current_path).to eq('/')

    click_link "Books"

    expect(current_path).to eq('/books')
  end

end
