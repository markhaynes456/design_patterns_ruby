#################
# Factory Pattern
#
# When to use
# If you do not know what class you will need
# encapsulate the creation of objects
# Hide the selection process away from the user 
# If you need to select one class at random from a list of classes which all contain the same superclass
#
# Characteristics
# Chosen at run time
# Random selection at run time
#
# Implementation
#
#
##############

module RobotGeneric

	def move
		raise NotImplementedError
	end

	def follow(target)
		raise NotImplementedError
	end

end

class Robot
	
	include RobotGeneric

	attr_reader :name

	@name = "Robot Abstract"

	def move
		puts("#{@name} moves around")
	end

	def follow(target)
		puts("#{@name} follows #{target}")
	end

	private
		attr_writer :name

end


class KillBot < Robot

	def shoot
		puts("#{name} shoots in the air")
	end

end

class HelperBot < Robot
	
end

class RobotFactory

	def initialize
		@robots = []
		self.register(KillBot)
		self.register(HelperBot)
	end

	def register(robot)
		@robots.push(robot.new)
	end

	def create_robot(id)
		@robots[id]
	end

	def build_robot
		@robots[rand(@robots.length)]
	end

	private
		attr_accessor :robots

end

RobotFactory.new.build_robot.follow("Jone")
RobotFactory.new.build_robot.follow("Ian")
