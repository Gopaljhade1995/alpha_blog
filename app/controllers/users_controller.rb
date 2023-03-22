class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
	def index
		@users = User.paginate(page: params[:page], per_page: 5)
	end
	
	def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

	def new
      @user = User.new
	end

	def edit

  end

    def update
     @user = User.find(params[:id])
     if @user.update(user_params)
     flash[:notice] = "User was updated successfully."
     redirect_to @user
     else
      render 'edit'
     end
    end

	  def create
	    if @user.save
         session[:user_id] = @user.id
	       flash[:notice] = "welcome to the Alpha Blog, you have successfully sined in"
	       redirect_to articles_path
	    else
	      render 'new'
	    end
    end

    def destroy
      @user.destroy
      redirect_to articles_path
    end

  private

    def user_params
       params.require(:user).permit(:username, :email, :password_digest)
    end
    def set_user
      @user = User.find(params[:id])
    end

end
