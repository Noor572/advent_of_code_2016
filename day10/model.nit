class Instruction
	var to: Element
	# Is the instruction to give `hi` ?
	var is_hi: Bool

	fun work(e: Bot) do
		var val
		if is_hi then
			val = e.pop_hi
		else
			val = e.pop_lo
		end
		to.chips.push val
	end
end

abstract class Element
	var chips = new Array[Int]
end

class Bot
	super Element

	var id: Int

	var instructions = new Array[Instruction]

	fun can_execute: Bool do return chips.length >= 2 and instructions.length >= 2

	fun execute do
		if not can_execute then return
		instructions.pop.work(self)
		instructions.pop.work(self)
	end

	fun pop_hi: Int do
		var hipos = 0
		var hival = chips[0]
		for i in [1 .. chips.length[ do
			if chips[i] > hival then
				hipos = i
				hival = chips[i]
			end
		end
		chips.remove_at hipos
		return hival
	end

	fun pop_lo: Int do
		var lopos = 0
		var loval = chips[0]
		for i in [1 .. chips.length[ do
			if chips[i] < loval then
				lopos = i
				loval = chips[i]
			end
		end
		chips.remove_at(lopos)
		return loval
	end

	redef fun to_s do return id.to_s
end

class Output
	super Element
end
