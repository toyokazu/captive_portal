class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def extract_params(ap_type)
    case ap_type
    when "aruba"
      session[:access_log] = {
        ap_type: ap_type,
        ap_mac: params[:ap_mac],
        essid: params[:essid],
        mac: params[:mac],
        ip: params[:ip],
        uid: nil,
        provider: nil,
        agreement: nil,
        timestamp: nil
      }.with_indifferent_access
      session[:redirection] = {
        url: params[:url]
      }.with_indifferent_access
    end
  end

  def extract_attributes(auth_hash)
    case auth_hash[:provider]
    when "facebook"
      session[:attribute_log] = {
        location: auth_hash[:location]
      }
    when "twitter"
      session[:attribute_log] = {
        location: auth_hash[:location]
      }
    when "google_oauth2"
      session[:attribute_log] = {
        location: auth_hash[:location]
      }
    end
  end
end
