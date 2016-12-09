fun parse_input(input: String, pos: Int, limit: Int): Int do
	var cnt = 0
	while pos < limit and pos < input.length do
		var c = input[pos]
		if c != '(' then
			if not c.is_whitespace then cnt += 1
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
		var wrt = parse_input(input, pos, pos + n_chars)
		cnt += wrt * repeat
		pos += n_chars
	end
	return cnt
end

var input = args[0].to_path.read_all

print parse_input(input, 0, input.length)
