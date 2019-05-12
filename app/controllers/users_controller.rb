class UsersController < ApplicationController

  def show
    if params[:table]
      @user = params[:id]
      @user_reviews = Review.sort_reviews(params[:table]).select {|review| review.user == params[:id]}
    else
      @user = params[:id]
      @user_reviews = Review.all.select {|review| review.user == params[:id]}
    end
  end

  def destroy
    @review = Review.find(params[:rev_id])
    @review.destroy

    redirect_to user_path(params[:id])
  end
end
