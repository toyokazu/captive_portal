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
    session[:access_log][:agreement] = params[:agreement]
    redirect_to authentication_path
  end
end
