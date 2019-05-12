class UsersController < ApplicationController

  def show
    @user = params[:id]
    @user_reviews = Review.all.select {|review| review.user == params[:id]}
  end
end
