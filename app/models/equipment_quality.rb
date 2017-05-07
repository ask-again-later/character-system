class EquipmentQuality < ApplicationRecord
  has_and_belongs_to_many :equipments
  has_and_belongs_to_many :equipment_types

  validates_presence_of :name
end
