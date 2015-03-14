module Flys

	def flys()
		raise NotImplementedError
	end

end

class ItFlys
	include Flys

	def flies?()
		true
	end

end

class CantFly
	include Flys

	def flies?()
		false
	end

end

class Animal
	attr_reader :flying_ability

	def initialize(flying_abillity)
		self.flying_abillity = flying_abillity
	end

	def flying_abillity=(flying_abillity)
		@flying_abillity = flying_abillity
	end

	def can_fly?
		@flying_abillity.flies?
	end

end

class Dog < Animal

end

class Bird < Animal

end

bird = Bird.new(ItFlys.new)
dog = Dog.new(CantFly.new)
puts bird.can_fly?
puts dog.can_fly?
