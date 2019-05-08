class BooksController < ApplicationController
  before_action :set_book, only: [:show, :destroy, :edit, :update]

  def show

  end

  def index
    if params[:table]
      @books = Book.sort_books_by(params[:table], params[:order])
    else
      @books = Book.all
  end

  def create
    book = Book.new(book_params)
    if book.save
      redirect_to books_path
    else
      render :new
  end

  def new
    @books = Book.new
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
    params.require(:book).permit(:title, :pages, :published, :year)
  end

  def set_book
    @book = Book.find(params[:id])
  end

end
