class BooksController < ApplicationController
  def index
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
  end

  def new
    @books = Book.new
  end

  def create
    book = Book.new(book_params)
    book.save

    redirect_to books_path
  end

  def destroy
    Book.destroy(params[:id])

    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :published, :year)
  end
end
