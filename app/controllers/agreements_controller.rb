class AgreementsController < ApplicationController
  AP_TYPES = ["aruba"]

  def new
    ap_type =
    if AP_TYPES.include?(params[:ap_type])
      params[:ap_type]
    else
      "aruba"
    end
    extract_params(ap_type)
  end

  def create
    if session[:access_log]["mac"].nil? || session[:access_log]["mac"].empty?
      redirect_to new_agreement_path, flash: {error: t('agreement.errors.mac_address_param_is_missing')}
    else
      session[:access_log]["agreement"] = params[:agreement]
      redirect_to auth_provider_path
    end
  end
end
