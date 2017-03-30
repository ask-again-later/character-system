class DowntimeAction < ApplicationRecord
  belongs_to :character
  belongs_to :game

  validates_presence_of :title, :description
end
