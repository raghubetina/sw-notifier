class Flight < ApplicationRecord
  validates :departs_at, :presence => true

  belongs_to :user
end
