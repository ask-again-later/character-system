class DowntimeAction < ApplicationRecord
  belongs_to :character
  belongs_to :downtime_period

  validates_presence_of :title, :description
end
