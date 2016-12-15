import asembunny_parser
import asembunny_lexer
import machine

fun build_machine(path: String): nullable AsembunnyInterpret do
	if not path.file_exists then return null
	var input = path.to_path.read_all
	var lex = new Lexer_asembunny(input)
	var parse = new Parser_asembunny
	var tks = lex.lex
	parse.tokens.add_all tks
	var root = parse.parse
	var visitor = new MachineVisitor
	visitor.enter_visit(root)
	return visitor.machine
end

class MachineVisitor
	super Visitor

	var machine = new AsembunnyInterpret

	redef fun visit(n) do
		n.accept_machine_visitor(self)
	end
end

redef class Node
	fun accept_machine_visitor(m: MachineVisitor) do visit_children(m)
end

redef class Nstmt_inc
	redef fun accept_machine_visitor(m) do
		var instr = new Inc(n_reg.text.first)
		m.machine.program.add instr
	end
end

redef class Nstmt_dec
	redef fun accept_machine_visitor(m) do
		var instr = new Dec(n_reg.text.first)
		m.machine.program.add instr
	end
end

redef class Nstmt_jnz_cst
	redef fun accept_machine_visitor(m) do
		var instr = new JnzCst(n_int.value, n_int2.value)
		m.machine.program.add instr
	end
end

redef class Nstmt_jnz_reg
	redef fun accept_machine_visitor(m) do
		var instr = new JnzReg(n_reg.text.first, n_int.value)
		m.machine.program.add instr
	end
end

redef class Nstmt_cpy_cst
	redef fun accept_machine_visitor(m) do
		var instr = new CpyCst(n_int.value, n_reg.text.first)
		m.machine.program.add instr
	end
end

redef class Nstmt_cpy_reg
	redef fun accept_machine_visitor(m) do
		var instr = new CpyReg(n_reg.text.first, n_reg2.text.first)
		m.machine.program.add instr
	end
end

redef class Nint
	fun value: Int do return text.to_i
end
