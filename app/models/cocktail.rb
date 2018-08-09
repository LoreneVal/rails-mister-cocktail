class Cocktail < ApplicationRecord
  has_many :doses, dependent: :destroy
  has_many :ingredients, through: :doses
  validates :name, presence: true, uniqueness: true
  mount_uploader :photo, PhotoUploader
  accepts_nested_attributes_for :doses, reject_if: proc { |c| c.attributes['ingredient_id'].blank?}
end
