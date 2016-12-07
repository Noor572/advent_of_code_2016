import md5

var input = args[0].to_path.read_all.trim

var pass = new Buffer
pass.append "00000000"

var seed = -1
var filled = 0

var found = [0,0,0,0,0,0,0,0]

while filled < 8 do
	seed += 1
	var hash = (input + seed.to_s).md5
	while not hash.has_prefix("00000") do
		seed += 1
		hash = (input + seed.to_s).md5
	end
	var c = hash[5]
	if c < '0' or c > '7' then continue
	var pos = hash[5].to_i
	if found[pos] != 0 then continue
	pass[pos] = hash[6]
	found[pos] = 1
	filled += 1
end
print "Password is `{pass}`"
