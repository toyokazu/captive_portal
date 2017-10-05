module ApplicationHelper
  def header_params
    @carried_params
  end

  def footer_params
    session[:access_log].reject {|k,v| v.nil?}
  end
end
