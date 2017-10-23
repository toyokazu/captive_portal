module ApplicationHelper
  def header_params
    if params[:controller] == "agreements"
      @access_log.extract_params
    else
      {}
    end
  end

  def footer_params
    @access_log.extract_params
  end
end
