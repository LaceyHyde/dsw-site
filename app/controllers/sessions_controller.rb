class SessionsController < ApplicationController

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:current_user_id] = @user.id
    redirect_to request.env['omniauth.origin'] || '/'
  end

  def destroy
    session.delete(:current_user_id)
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
