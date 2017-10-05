class ApAuthHandlersController < ApplicationController
  layout "ap_redirect"

  def show
    if session[:access_log]["uid"].nil?
      redirect_to new_agreement_path, flash: {error: t('ap_auth_handlers.errors.not_authorized')}
    end
  end
end
