import balance_parser
import model

class InitVisitor
	super Visitor
	var model = new HashMap[Int, Bot]

	redef fun visit(n) do n.accept_init_visitor(self)
end

redef class Node
	fun accept_init_visitor(v: InitVisitor) do
		visit_children(v)
	end
end

redef class Nstmt_assign
	redef fun accept_init_visitor(v) do
		var val = n_int.value
		var to = n_int2.value
		var mod = v.model
		if not mod.has_key(to) then mod[to] = new Bot(to)
		var b = mod[to]
		b.chips.add val
	end
end

redef class Nint
	var value: Int is lazy do return text.to_i
end
