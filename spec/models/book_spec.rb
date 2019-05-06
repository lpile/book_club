require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "validations" do
    it {should validate_presence_of(:title)}
    it {should validate_presence_of(:pages)}
    it {should validate_presence_of(:authors)}
    it {should validate_presence_of(:published)}
    it {should validate_presence_of(:image)}
  end
end
