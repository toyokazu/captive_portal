class AuthProvidersController < ApplicationController
  def index
    @access_log = AccessLog.new(session[:access_log])
    @providers = [
      'facebook',
      'twitter',
      'google_oauth2',
      'identity'
    ]
  end
end
