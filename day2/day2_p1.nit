class Cursor
	var pos = 5

	fun move(dir: Char) do
		if dir == 'R' then
			if pos % 3 == 0 then return
			pos += 1
		else if dir == 'L' then
			if pos % 3 == 1 then return
			pos -= 1
		else if dir == 'U' then
			pos -= 3
			if pos < 1 then pos += 3
		else if dir == 'D' then
			pos += 3
			if pos > 9 then pos -= 3
		else
			print "Unknown command `{dir}`"
		end
	end
end

var input = args[0].to_path.read_all
var il = input.split('\n')
var curse = new Cursor
for i in il do
	if i == "" then continue
	for j in i do curse.move(j)
	printn curse.pos
end
print ""
