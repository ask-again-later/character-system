class EquipmentType < ApplicationRecord
  has_many :equipments
  has_many :equipment_qualities

  validates_presence_of :name
end
