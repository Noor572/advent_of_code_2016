import counter

var input = args[0].to_path.read_all.split('\n')

var pass = new Buffer
for j in [0 .. input.first.length[ do
	var cnt = new Counter[Char]
	for i in input do
		if i == "" then continue
		cnt.inc i[j]
	end
	pass.add cnt.sort.reversed.first
end

print pass
