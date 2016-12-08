import two_factor_auth_parser

class TFALiteralVisitor
	super Visitor

	redef fun visit(n) do n.accept_literal(self)
end

redef class Node
	fun accept_literal(v: TFALiteralVisitor) do visit_children(v)
end

redef class Nint
	var value: Int is noinit

	redef fun accept_literal(v) do
		value = text.to_i
	end
end
