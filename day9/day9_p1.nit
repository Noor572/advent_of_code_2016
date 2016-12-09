redef class Text
	fun no_whitespace_length: Int do
		var cnt = 0
		for i in self do if not i.is_whitespace then cnt += 1
		return cnt
	end
end

var input = args[0].to_path.read_all

var obuf = new Buffer
var pos = 0
obuf.clear
while pos < input.length do
	var c = input[pos]
	if c != '(' then
		obuf.add c
		pos += 1
		continue
	end
	pos += 1
	var nc_st = pos
	while c != 'x' do
		pos += 1
		c = input[pos]
	end
	var nc_end = pos
	var n_chars = input.substring(nc_st, nc_end - nc_st).to_i
	pos += 1
	var r_st = pos
	while c != ')' do
		pos += 1
		c = input[pos]
	end
	var r_end = pos
	var repeat = input.substring(r_st, r_end - r_st).to_i
	pos += 1
	var a_s = input.substring(pos, n_chars)
	for i in [0 .. repeat[ do obuf.append(a_s)
	pos += n_chars
end
input = obuf.to_s
pos = 0

print input.no_whitespace_length
