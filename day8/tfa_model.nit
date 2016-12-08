import tfa_literal

class Screen
	var pixels = new Array[Array[Bool]]

	init do
		for i in [0 .. 6[ do
			pixels.add new Array[Bool]
			for j in [0 .. 50[ do pixels[i].add false 
		end
	end

	fun fetch_column(x: Int): Array[Bool] do
		var ret = new Array[Bool]
		for i in [0 .. pixels.length[ do
			ret.push pixels[i][x]
		end
		return ret
	end

	fun replace_column(x: Int, pix: Array[Bool]) do
		for i in [0 .. pixels.length[ do
			pixels[i][x] = pix[i]
		end
	end

	fun rotate_column(x: Int, len: Int) do
		var col = fetch_column(x)
		for i in [0 .. len[ do
			var e = col.pop
			col.unshift e
		end
		replace_column(x, col)
	end

	fun rotate_row(x: Int, len: Int) do
		var row = pixels[x]
		for i in [0 .. len[ do
			var e = row.pop
			row.unshift e
		end
	end

	fun rectangle(xsz, ysz: Int) do
		for i in [0 .. ysz[ do
			for j in [0 .. xsz[ do
				pixels[i][j] = true
			end
		end
	end

	fun lit_count: Int do
		var cnt = 0
		for i in pixels do
			for j in i do if j then cnt += 1
		end
		return cnt
	end

	redef fun to_s do
		var buf = new Buffer
		for i in pixels do
			for j in i do
				if j then buf.add '#' else buf.add '.'
			end
			buf.add '\n'
		end
		return buf.to_s
	end
end

class ScreenVisitor
	super Visitor

	var screen = new Screen

	redef fun visit(n) do n.accept_screen_visitor(self)
end

redef class Node
	fun accept_screen_visitor(v: ScreenVisitor) do visit_children(v)
end

redef class Ninstr_rect
	redef fun accept_screen_visitor(v) do
		v.screen.rectangle(n_int.value, n_int2.value)
		print v.screen
		print "-" * 20
	end
end

redef class Ninstr_rotrow
	redef fun accept_screen_visitor(v) do
		v.screen.rotate_row(n_int.value, n_int2.value)
		print v.screen
		print "-" * 20
	end
end

redef class Ninstr_rotcol
	redef fun accept_screen_visitor(v) do
		v.screen.rotate_column(n_int.value, n_int2.value)
		print v.screen
		print "-" * 20
	end
end
