class ApAuthHandlersController < ApplicationController
  layout "ap_redirect"

  def show
    @access_log = AccessLog.new(session[:access_log])
    if session[:access_log]["uid"].nil?
      redirect_to new_agreement_path(@access_log.extract_params), flash: {error: t('ap_auth_handlers.errors.not_authorized')}
    end
  end
end
