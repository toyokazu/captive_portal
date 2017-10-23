class IdentitiesController < ApplicationController
  protect_from_forgery except: [:new, :login], with: :exception

  def new
    @identity = identity
  end

  def login
  end

  protected

  def identity
    request.env['omniauth.identity']
  end
end
