class DowntimePeriod < ApplicationRecord
  has_many :downtime_actions
end
