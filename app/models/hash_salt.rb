class HashSalt < ApplicationRecord
  validates :salt, presence: true
  validates :salt, length: { is: 32 }
end
