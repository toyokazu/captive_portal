module IdentitiesHelper
  def extract_validation_errors
    if !@identity.nil? && !@identity.errors.nil?
      flash[:error] = @identity.errors.messages.sort.map do |attr, msg|
        "\"#{t('auth_identity_register.' + attr.to_s)} #{msg.first}\""
      end.join(", ")
    end
  end
end
