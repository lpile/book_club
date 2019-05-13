class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
  end

  def destroy
    Author.destroy(params[:id])

    redirect_to books_path
  end
  
private

  def author_params
    params.require(:authors).permit(:name)
  end
end
