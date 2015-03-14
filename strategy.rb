module Flys

	def flys()
		raise NotImplementedError
	end

end

class ItFlys
	include Flys

	def flys()
		true
	end

end

class CantFly
	include Flys

	def flys()
		false
	end

end

class Animal
	attr_reader :flying_ability

	def initialize(flying_abillity)
		self.set_flying_abillity(flying_abillity)
	end

	def set_flying_abillity(flying_abillity)
		@flying_abillity = flying_abillity
	end

	def can_fly?
		@flying_abillity.flys
	end

end

class Dog < Animal

	def initialize(flying_abillity)
		super(flying_abillity)
	end

end

class Bird < Animal

end

bird = Bird.new(ItFlys.new)
dog = Dog.new(CantFly.new)
puts dog.can_fly?
