class EquipmentQuality < ApplicationRecord
  has_and_belongs_to_many :equipments
  belongs_to :equipment_type

  validates_presence_of :name
end
