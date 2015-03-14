####################################################################################
# Oberserver pattern - Ruby
# When to use
# When many objects need to be notified when an update is made to another object
# Key components 
#	Subject = publisher and Observer = subscribers
# Benefit 
#	loose coupling
####################################################################################

# Mixin to substitue the subject interface

module Subject

	def register(observer)
		raise NotImplementedError
	end

	def unregister(observer)
		raise NotImplementedError
	end

	def notify(observer)
		raise NotImplementedError
	end

end

module Observer

	def update()
		raise NotImplementedError
	end

end

class Shop

	include Subject

	def initialize(bacon_price, egg_price, milk_price)
		@observers = []
		@bacon_price = bacon_price
		@egg_price = egg_price
		@milk_price = milk_price
	end

	def register(observer)
		@observers.push(observer)
		self.notify
	end

	def unregister(observer)
		@observers.delete_at(@observers.find_index(observer))
	end

	def notify()
		 @observers.each do |observer|
			observer.update(@bacon_price, @egg_price, @milkprice)
		end
	end

	def bacon_price=(new_price)
		@bacon_price = new_price
		self.notify
	end

	def milk_price=(new_price)
		@milk_price = new_price
		self.notify
	end

	def egg_price=(new_price)
		@egg_price = new_price
		self.notify
	end

	private

		attr_accessor :baconPrice, :eggPrice, :milkPrice

end

class Customer

	include Observer

	attr_reader :bacon_price, :egg_price, :milk_price

	def update(bacon_price, egg_price, milk_price)
		@bacon_price = bacon_price
		@egg_price = egg_price
		@milk_price = milk_price
	end

	private
		
	attr_writer :bacon_price, :egg_price, :milk_price

end


shop = Shop.new(3,2,1)
mark = Customer.new
john = Customer.new
ann = Customer.new

shop.register(mark)
shop.register(john)
shop.register(ann)

puts "On register Mark recevied a message that bacon costed: #{mark.bacon_price} "
shop.bacon_price = 5
puts "bacon went up in price and john receved a message of the new price: #{john.bacon_price}"
puts 'Ann stopped asking the store for updates on her three fave items'
shop.unregister(ann)
puts 'bacon price changes to 4'
shop.bacon_price = 4
puts "Ann stopped observing the shop and knows the last price as: #{ann.bacon_price}"
puts "John who is stil monitoring the price of bacon saw the price drop to: #{john.bacon_price}"
