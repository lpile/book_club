class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
  end

  def destroy
    Author.destroy(params[:id])

    redirect_to books_path
  end

  # def create
  #   @book = Book.find(params[:book_id])
  #   @book.authors.create(author_params)
  #
  #   redirect_to books_path
  # end
  #
  # def new
  #   @author = Author.new
  #   @book = Book.find(params[:book_id])
  # end



private

  def author_params
    params.require(:authors).permit(:name)
  end
end
