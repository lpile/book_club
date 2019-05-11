class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  def show

  end

  def index
    if params[:table]
      @books = Book.sort_books_by(:table)
    else
      @books = Book.all
    end
  end

  def create
    author = Author.find_or_create_by(name: author_params[:authors])
    book = Book.new(book_params)

    book.authors << author
    book.save
    
    redirect_to books_path
  end

  def new
    @book = Book.new
  end

  def edit

  end

  def update
    @book.update(book_params)

    redirect_to book_path(@book)
  end

  def destroy
    @book.destroy

    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :pages, :published, :image)
  end

  def author_params
    params.require(:book).permit(:authors)
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
