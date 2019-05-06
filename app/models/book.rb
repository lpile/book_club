class Book < ApplicationRecord

  validates_presence_of :title, :pages, :authors, :published, :image
end
