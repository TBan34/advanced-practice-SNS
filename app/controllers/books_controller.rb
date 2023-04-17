class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def index
    @book = Book.new
    last_week = ((Time.current.at_end_of_day - 6.day).at_beginning_of_day)..(Time.current.at_end_of_day)
    @books = Book.includes(:favorited_users)
      .sort{|a,b| 
        b.favorited_users.includes(:favorites).where(created_at: last_week).size <=> 
        a.favorited_users.includes(:favorites).where(created_at: last_week).size
        }
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    @book_comment = BookComment.new
    impressionist(@book, nil, unique: [:ip_address])
  end

  def edit
    @book = Book.find(params[:id])
    login_user_id = current_user.id
    if(@book.user_id != login_user_id)
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.delete
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :user_id)
  end
end
