class AgreementsController < ApplicationController
  protect_from_forgery except: :new, with: :exception

  def new
    extract_params
    @access_log = AccessLog.new(session[:access_log])
  end

  def create
    @access_log = AccessLog.new(session[:access_log])
    if session[:access_log]["mac"].nil? || session[:access_log]["mac"].empty?
      redirect_to new_agreement_path(@access_log.extract_params), flash: {error: t('agreement.errors.mac_address_param_is_missing')}
    else
      session[:access_log]["agreement"] = params[:agreement]
      redirect_to auth_providers_path
    end
  end
end
