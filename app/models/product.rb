class Product < ApplicationRecord
	validates :title, :description, :image_url, presence: true
	validates :price, numericality: { greater_than_or_equal_to: 0.01 }
	validates :title, uniqueness: true
	validates :title, length: {
		in: 10..255,
		too_short: "%{count} es el número mínimo de caracteres requeridos para el título.",
		too_long: "%{count} es el número máximo de caracteres permitidos para el título."
	}
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)}i,
		message: 'must be a URL for GIF, JPG or PNG image.'
	}
end