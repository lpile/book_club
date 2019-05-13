class UsersController < ApplicationController

  def show
    @user = params[:id]
    if params[:table]
      @user_reviews = Review.sort_reviews(params[:table]).sort_user(@user)
    else
      @user_reviews = Review.all.sort_user(@user)
    end
  end

  def destroy
    @review = Review.find(params[:rev_id])
    @review.destroy

    redirect_to user_path(params[:id])
  end
end
