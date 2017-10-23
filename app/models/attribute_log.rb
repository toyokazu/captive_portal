class AttributeLog < ApplicationRecord
  attr_reader :mac
  validates_presence_of :amac

  def mac=(unencrypted_mac)
    @mac = unencrypted_mac
    salt = HashSalt.order('created_at DESC').first
    @mac = nil if salt.nil?
    if @mac && !@mac.empty?
      self.amac = Base64.strict_encode64(OpenSSL::Digest.digest("sha256", salt.salt + @mac))
    end
  end
end
