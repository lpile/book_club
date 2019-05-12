class UsersController < ApplicationController

  def show
    @user = params[:id]
    @user_reviews = Review.all.select {|review| review.user == params[:id]}
  end

  def destroy
    @review = Review.find(params[:rev_id])
    @review.destroy

    redirect_to user_path(params[:id])
  end
end
