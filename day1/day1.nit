import console

class Santa
	var loc_history = new HashMap[Int, HashMap[Int, Bool]]

	var coords = new Couple[Int, Int](0, 0)

	var found_crossing = false

	fun x: Int do return coords.first
	fun y: Int do return coords.second

	# Direction santa is facing:
	# - 0 is North
	# - 1 is East
	# - 2 is South
	# - 3 is West
	var direction = 0

	fun turn_left do
		direction -= 1
		if direction < 0 then direction += 4
	end

	fun turn_right do
		direction += 1
		direction %= 4
	end

	fun move(len: Int) do
		# print "Santa moving in direction {direction} for {len} steps"
		assert direction >= 0 and direction <= 3
		for i in [0 .. len[ do
			log_pos
			if direction == 0 then
				coords.second -= 1
			else if direction == 1 then
				coords.first += 1
			else if direction == 2 then
				coords.second += 1
			else if direction == 3 then
				coords.first -= 1
			end
		end
	end

	fun log_pos do
		# print "Logging position ({x},{y})".red
		if not loc_history.has_key(x) then
			loc_history[x] = new HashMap[Int, Bool]
		end
		if loc_history[x].has_key(y) and not found_crossing then
			print "Location already visited: ({x}, {y})".red
			print "Distance from home: {x.abs + y.abs}".green
			found_crossing = true
		else
			loc_history[x][y] = true
		end
	end
end

var input = args[0].to_path.read_all
var in_coords = input.split(',')
var santa = new Santa
for i in in_coords do
	var dir = i.trim.first
	var len = i.trim.substring_from(1).to_i
	#print "Movement is {dir}{len}"
	if dir == 'R' then santa.turn_right else santa.turn_left
	santa.move(len)
end

print "Bunny HQ position is ({santa.coords.first}, {santa.coords.second})"
print "Distance is {santa.coords.first.abs + santa.coords.second.abs}"
