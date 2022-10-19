class ForgetpasswordMailer < ApplicationMailer
	def forgetpassword(user)
      @user = user
      @url  = 'http://www.gmail.com'
      mail(to: @user.email, subject: 'Welcome to Chetu  Site')
  end
end
