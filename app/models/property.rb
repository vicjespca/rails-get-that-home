class Property < ApplicationRecord
  has_many :users_props, class_name: "UsersProp"
  has_many :users, through: :users_props
  has_many :photos, dependent: :destroy

  validates :address, presence: true
  validates :type_operation, presence: true
  validates :type_property, presence: true
  validates :bedrooms, presence: true
  validates :bathrooms, presence: true
  validates :area, presence: true

  enum type_operation: { rent: 0, sale: 1 }
  enum type_property: { apartment: 0, house: 1 }

  # def as_json(options = {})
  #   super(options.merge(include: :photos)).tap do |json|
  #     json['photo_urls'] = photo_urls
  #   end
  # end

  def photo_urls
    photos.map do |photo|
      photo.image
    end
  end
end
