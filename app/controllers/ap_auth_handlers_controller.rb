class ApAuthHandlersController < ApplicationController
  layout "ap_redirect"

  def show
    if session[:access_log]["uid"].nil?
      update_carried_params
      redirect_to new_agreement_path(@carried_params), flash: {error: t('ap_auth_handlers.errors.not_authorized')}
    end
  end
end
