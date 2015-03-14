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

	attr_accessor :baconPrice, :eggPrice, :milkPrice

	def initialize(baconPrice, eggPrice, milkPrice)
		@observers = []
		self.baconPrice = baconPrice
		self.eggPrice = eggPrice
		self.milkPrice = milkPrice
	end

	def register(observer)
		@observers.push(observer)
	end

	def unregister(observer)
		puts @observers.delete_at(@observers.find_index(observer))
	end

	def notify()
		 @observers.each do |observer|
			observer.update(@baconPrice, @eggPrice, @milkPrice)
		end
	end

end

class Customer

	include Observer

	attr_accessor :baconPrice, :eggPrice, :milkPrice

	def update(baconPrice, eggPrice, milkPrice)
		self.baconPrice = baconPrice
		self.eggPrice = eggPrice
		self.milkPrice = milkPrice
	end
end


shop = Shop.new(3,2,1)
mark = Customer.new
john = Customer.new
ann = Customer.new

shop.register(mark)
shop.register(john)
shop.register(ann)
shop.notify
puts "mark recevied a message that bacon costed: #{mark.baconPrice} "

shop.baconPrice = 5
shop.notify

puts "bacon went up in price and john receved a message of the new price: #{john.baconPrice}"

shop.unregister(ann)
shop.baconPrice = 4
shop.notify

puts "Ann stopped observing the shop and know the last price as: #{ann.baconPrice}"
puts "John who is stil monitoring the price of bacon saw the price drop to: #{john.baconPrice}"

