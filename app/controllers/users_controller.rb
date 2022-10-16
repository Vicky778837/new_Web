class UsersController < ApplicationController
	  before_action :logged_in_user, only: [:show]
def index
  @users  = User.all
  @users = User.paginate(:page => params[:page], :per_page => 3)

end
 def show
    @user = User.find(params[:id])
  end

  def profile
   current_user
 end
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the app!"
      redirect_to @user
    else
      render 'new'
    end
  end
  def change_password
    @user =  current_user
   end
     def update_password
       @user =  current_user
       @user.authenticate(params[:user][:password_digest]).present?
       params[:user][:password] == params[:user][:password_confirmation]
         if @user.update(password_digest:params[:user][:password])
           redirect_to root_url, :notice => "Password has been changed!"
         else
           render "edit" 
         end
     end
     def destroy
      @user = User.find(params[:id])
      if @user.destroy
        redirect_to login_path
      end
     end
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,:avatar)
  end
end


  