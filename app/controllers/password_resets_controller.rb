class PasswordResetsController < ApplicationController
  def new
  end


  def create
    byebug
  user = User.find_by_email(params[:email].downcase)
  user.send_password_reset if user
  flash[:notice] = 'E-mail sent with password reset instructions.'
  redirect_to "/"
end

def edit
  byebug
  @user = User.find_by_password_reset_token!(params[:id])
end

def update
  byebug
  @user = User.find_by_password_reset_token!(params[:id])
  if @user.password_reset_sent_at < 2.hour.ago
    flash[:notice] = 'Password reset has expired'
    redirect_to new_password_reset_path
  elsif @user.update(user_params)
    flash[:notice] = 'Password has been reset!'
    redirect_to '/'
  else
    render :edit
  end
end

private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:password)
  end

end
