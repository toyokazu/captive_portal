class SessionsController < ApplicationController
  def create
    session[:access_log][:uid] = auth_hash[:uid]
    session[:access_log][:provider] = auth_hash[:provider]
    extract_attributes(auth_hash)
    redirect_to(auth_origin)
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def auth_origin
    request.env['omniauth.origin']
  end
end
