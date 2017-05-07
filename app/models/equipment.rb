class Equipment < ApplicationRecord
  has_and_belongs_to_many :characters
  has_and_belongs_to_many :equipment_qualities
  belongs_to :equipment_type

  validates_presence_of :name
end
