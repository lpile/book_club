class Book < ApplicationRecord
  validates_presence_of :title, :pages, :published, :image

  has_many :reviews
end
