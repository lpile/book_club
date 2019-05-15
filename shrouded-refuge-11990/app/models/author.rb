class Author < ApplicationRecord
  before_save { self.name = name.titlecase }

  validates_presence_of :name

  has_many :author_books, dependent: :destroy
  has_many :books, through: :author_books

  validates :name, uniqueness: true

end
