import init_values

class InstructionVisitor
	super Visitor

	var bots: HashMap[Int, Bot]
	var outputs = new HashMap[Int, Output]

	redef fun visit(n) do n.accept_instruction_visitor(self)

	fun get_or_create_element(id: Int, el_type: Bool): Element do
		if el_type then
			if not bots.has_key(id) then bots[id] = new Bot(id)
			return bots[id]
		end
		if not outputs.has_key(id) then outputs[id] = new Output
		return outputs[id]
	end
end

redef class Node
	fun accept_instruction_visitor(v: InstructionVisitor) do
		visit_children(v)
	end
end

redef class Nstmt_instr
	redef fun accept_instruction_visitor(v) do
		var el_type = n_recv isa Nrecv_bot
		var el = v.get_or_create_element(n_int2.value, el_type)
		var instruction_1 = new Instruction(el , false)
		el_type = n_recv2 isa Nrecv_bot
		el = v.get_or_create_element(n_int3.value, el_type)
		var instruction_2 = new Instruction(el, true)
		var recv = v.get_or_create_element(n_int.value, true)
		assert recv isa Bot
		recv.instructions.push instruction_1
		recv.instructions.push instruction_2
	end
end
