import md5

var input = args[0].to_path.read_all.trim

var pass = new Buffer

var seed = -1
for i in [0 .. 8[ do
	seed += 1
	var hash = (input + seed.to_s).md5
	while not hash.has_prefix("00000") do
		seed += 1
		hash = (input + seed.to_s).md5
	end
	pass.add hash[5]
end
print "Password is `{pass}`"
