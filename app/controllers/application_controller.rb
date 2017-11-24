class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  protected

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    {locale: I18n.locale}.merge options
  end

  def extract_params
    case params[:ap_type]
      when "aruba"
        init_session_values_for_aruba
      else
        init_session_values
    end
  end

  def init_session_values
    init_session_values_for_aruba
  end

  def init_session_values_for_aruba
    session[:access_log] = {
        ap_type: "aruba",
        ap_mac: params[:ap_mac],
        essid: params[:essid],
        mac: params[:mac],
        ip: params[:ip],
        uid: nil,
        provider: nil,
        agreement: nil
    }
    session[:redirection] = {
        url: params[:url]
    }
  end

  def extract_attributes(auth_hash)
    case auth_hash["provider"]
      when "facebook"
        session[:attribute_log] = {
            portal_locale: I18n.locale,
            location: auth_hash.info['location'],
            email: auth_hash.info['email']
        }
      when "twitter"
        session[:attribute_log] = {
            portal_locale: I18n.locale,
            location: auth_hash.info['location'],
            email: auth_hash.info['email'],
            timezone: auth_hash.info['time_zone']
        }
      when "google_oauth2"
        session[:attribute_log] = {
            portal_locale: I18n.locale,
            location: auth_hash.info['location'],
            email: auth_hash.info['email'],
            locale: auth_hash.extra.raw_info.locale
        }
      when "identity"
        session[:attribute_log] = {
            portal_locale: I18n.locale
        }
    end
  end
end
