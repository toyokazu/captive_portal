class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :init_carried_params

  protected
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options = {})
    { locale: I18n.locale }.merge options
  end

  def extract_params
    case params[:ap_type]
    when "aruba"
      init_default_session_values
    else
      init_default_session_values
    end
  end

  def init_default_session_values
    session[:access_log] = {
      ap_type: "aruba",
      ap_mac: params[:ap_mac],
      essid: params[:essid],
      mac: params[:mac],
      ip: params[:ip],
      uid: nil,
      provider: nil,
      agreement: nil,
      timestamp: nil
    }
    session[:redirection] = {
      url: params[:url]
    }
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

  def init_carried_params
    @carried_params = {}
  end

  def update_carried_params
    @carried_params = @carried_params.merge(session[:access_log].reject {|k,v| v.nil?})
  end
end
