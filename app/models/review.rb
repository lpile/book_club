class Review < ApplicationRecord
  validates_presence_of :title, :user, :rating, :comment

  belongs_to :book

end
