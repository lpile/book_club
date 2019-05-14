require 'rails_helper'

RSpec.describe "Welcome's Index Page,", type: :feature do
  describe "As a visitor," do
    it "it says Welcome" do

      visit '/'

      expect(page).to have_content("Welcome")
    end
  end
end
