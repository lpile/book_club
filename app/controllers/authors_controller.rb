class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
  end

  def destroy
    Author.destroy(params[:id])
    # Author.books.each(&:destroy)
    redirect_to books_path
  end
end
