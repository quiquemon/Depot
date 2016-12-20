class CombineItemsInCart < ActiveRecord::Migration[5.0]
	def up
		# Replace multiple items for a single product in a cart with a single item
		Cart.all.each do |cart|
			# Count the number of every product in the cart
			sums = cart.line_items.group(:product_id).sum(:quantity)
			
			sums.each do |product_id, quantity|
				if quantity > 1
					# Remove individual items
					cart.line_items.where(product_id: product_id).delete_all
					# Replace with a single item
					cart.line_items.create(product_id: product_id, quantity: quantity)
				end
			end
		end
	end
	
	def down
		# Split items with quantity > 1 into multiple items
		LineItem.where('quantity > 1').each do |item|
			# Add individual items
			item.quantity.times do
				LineItem.create(cart_id: item.cart_id, product_id: item.product_id, quantity: 1)
			end
			
			# Remove original item
			item.destroy
		end
	end
end