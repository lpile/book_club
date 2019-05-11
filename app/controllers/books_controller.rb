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
    book = Book.new({
      title: params[:book][:title].titlecase,
      pages: params[:book][:pages],
      published: params[:book][:published],
      image: params[:book][:image]
      })

    book.authors << create_authors
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

  def create_authors
    split_authors.map{|author| Author.find_or_create_by(name: author.titlecase)}
  end

  def split_authors
    params[:book][:authors].split(", ")
  end

  def set_book
    @book = Book.find(params[:id])
  end
end
