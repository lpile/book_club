class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def show

  end

  def create
    @book = Book.find(params[:book_id])

    create_review unless check_user(params[:review][:user])

    redirect_to book_path(@book)
  end

  def new
    
    @review = Review.new
    @book = Book.find(params[:book_id])
  end

  def edit

  end

  def update
    @review.update(review_params)

    redirect_to review_path(@review)
  end

  def destroy
    @review.destroy

    redirect_to books_path
  end

  private

  def review_params
    params.require(:review).permit(:title, :user, :rating, :comment)
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def check_user(user)
    @book.review_users.include?(user.titlecase)
  end

  def create_review
    @review = Review.new(review_params)

    @book.reviews << @review
    @review.save
  end
end
