class AgreementsController < ApplicationController
  def new
    extract_params
    update_carried_params
  end

  def create
    if session[:access_log]["mac"].nil? || session[:access_log]["mac"].empty?
      update_carried_params
      redirect_to new_agreement_path(@carried_params), flash: {error: t('agreement.errors.mac_address_param_is_missing')}
    else
      session[:access_log]["agreement"] = params[:agreement]
      redirect_to auth_provider_path
    end
  end
end
