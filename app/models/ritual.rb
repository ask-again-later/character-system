class Ritual < ApplicationRecord
  has_and_belongs_to_many :characters
  
  accepts_nested_attributes_for :characters
end
