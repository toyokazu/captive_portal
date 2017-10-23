class AccessLog < ApplicationRecord
  validates_presence_of :ap_type
  validates_presence_of :mac
  validates_presence_of :provider
  validates_presence_of :agreement

  def extract_params
    self.attributes.reject {|k,v| v.nil? || k == "agreement"}
  end
end
