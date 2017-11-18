class SessionsController < ApplicationController
  def create
    # for testing
    #@auth_hash = auth_hash
    session[:access_log]['uid'] = auth_hash.uid
    session[:access_log]['provider'] = auth_hash.provider
    extract_attributes(auth_hash)
    @access_log = AccessLog.new(session[:access_log])
    @attribute_log = AttributeLog.new(session[:attribute_log].merge(mac: @access_log.mac))
    if !(@attribute_log.save && @access_log.save)
      redirect_to new_agreement_path(@access_log.extract_params), flash: {error: t('sessions.salt_is_missing') +
        ' | ' + @attribute_log.errors.messages.map {|attr,msg| "#{attr} #{msg.first}"}.join(', ') +
        ' | ' + @access_log.errors.messages.map {|attr,msg| "#{attr} #{msg.first}"}.join(', ')}
    else
      redirect_to(auth_origin)
    end
  end

  def failure
    @access_log = AccessLog.new(session[:access_log])
    redirect_to new_agreement_path(@access_log.extract_params), flash: {error: params[:message]}
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def auth_origin
    request.env['omniauth.origin'] || params[:origin]
  end
end
