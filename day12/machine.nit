class Instruction
	fun get_reg(id: Char, m: AsembunnyInterpret): Int do return m.regs[m.regs_ids.index_of(id)]

	fun set_reg=(id: Char, m: AsembunnyInterpret, value: Int) do
		m.regs[m.regs_ids.index_of(id)] = value
	end

	fun execute(m: AsembunnyInterpret) is abstract
end

class Inc
	super Instruction

	var reg: Char

	redef fun execute(m) do
		var reg_val = get_reg(reg, m)
		reg_val += 1
		set_reg(reg, m) = reg_val
	end
end

class Dec
	super Instruction

	var reg: Char

	redef fun execute(m) do
		var reg_val = get_reg(reg, m)
		reg_val -= 1
		set_reg(reg, m) = reg_val
	end
end

class JnzCst
	super Instruction

	var lval: Int
	var rval: Int

	redef fun execute(m) do
		if lval == 0 then return
		m.pc += rval
		# Absorbs overshoot due to PC increment before executing instruction
		m.pc -= 1
	end
end

class JnzReg
	super Instruction

	var reg: Char
	var rval: Int

	redef fun execute(m) do
		var reg_val = get_reg(reg, m)
		if reg_val == 0 then return
		m.pc += rval
		m.pc -= 1
	end
end

class CpyCst
	super Instruction

	var lval: Int
	var reg: Char

	redef fun execute(m) do
		set_reg(reg, m) = lval
	end
end

class CpyReg
	super Instruction

	var lreg: Char
	var rreg: Char

	redef fun execute(m) do
		var reg_val = get_reg(lreg, m)
		set_reg(rreg, m) = reg_val
	end
end

class AsembunnyInterpret
	var regs: Array[Int] = [0, 0, 0, 0]
	var regs_ids: Array[Char] = ['a', 'b', 'c', 'd']

	var pc = 0

	var program = new Array[Instruction]

	fun reset do
		pc = 0
		for i in [0 .. regs.length[ do regs[i] = 0
	end

	fun execute do
		while pc < program.length do
			var instr = program[pc]
			pc += 1
			instr.execute(self)
		end
	end

	fun state: String do
		var b = new Buffer
		b.append("Machine state\n")
		b.append("-" * 10)
		b.add('\n')
		b.append("PC: {pc}\n")
		b.append("a: {regs[regs_ids.index_of('a')]}\n")
		b.append("b: {regs[regs_ids.index_of('b')]}\n")
		b.append("c: {regs[regs_ids.index_of('c')]}\n")
		b.append("d: {regs[regs_ids.index_of('d')]}\n")
		b.append("-" * 10)
		b.add('\n')
		return b.to_s
	end
end
