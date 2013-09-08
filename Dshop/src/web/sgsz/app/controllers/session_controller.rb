class SessionController < ApplicationController
  skip_before_filter :authorize

  def new
  end

  def create
   if user = User.authenticate(params[:name], params[:password])
     session[:user_id] = user.id
     redirect_to admin_url
   else
     redirect_to login_url, :alert => t('views.invalid_user_or_password')
   end
 end

 def destroy
   session[:user_id] = nil
   redirect_to admin_url, notice => t('views.logged_out') 
 end
end
