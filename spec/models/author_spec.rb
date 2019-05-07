require "rails_helper"

RSpec.describe Author, type: :model do
  describe "relationships" do
    it { should have_many :author_books}
    it {should have_many(:books).through(:author_books)}
  end

end
