class Item < ActiveRecord::Base
	validates :name, presence: true
	validates :price, presence: true, numericality: true
	validates :quantity, presence: true, numericality: { only_integer: true }
	validates :image, presence: true
	validates :description, presence: true

	mount_uploader :image, ImageUploader

	self.per_page = 5
end
