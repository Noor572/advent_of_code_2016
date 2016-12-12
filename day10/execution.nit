import model
import init_values
import instruction_parser
import balance_lexer

import console

# For day10 p1
redef class Bot
	redef fun execute do
		if chips.has(61) and chips.has(17) then print "Bot {id} gives values 61 and 17".red
		super
	end
end

fun dump_model(m: HashMap[Int, Element]) do
	for k, v in m do
		print "{v.class_name} {k} existing"
		print "Chips are: [{v.chips.join(", ")}]"
	end
end

fun ready_list(m: HashMap[Int, Bot]): Array[Bot]do
	var ready = new Array[Bot]
	for k, v in m do
		if v.can_execute then ready.push v
	end
	return ready
end

var input = args[0].to_path.read_all
var lex = new Lexer_balance(input)
var parse = new Parser_balance

var tks = lex.lex
parse.tokens.add_all tks

var root = parse.parse
var init_vals = new InitVisitor
init_vals.enter_visit(root)

var instr_visit = new InstructionVisitor(init_vals.model)
instr_visit.enter_visit(root)

var bots = instr_visit.bots
while not ready_list(bots).is_empty do
	var rd = ready_list(bots)
	print "Execution of instructions for bots [{rd.join(", ")}]"
	for i in rd do i.execute
end

var outs = instr_visit.outputs
var o0 = outs[0]
var o1 = outs[1]
var o2 = outs[2]

var total = o0.chips.first
for i in [1 .. o0.chips.length[ do total *= o0.chips[i]
for i in o1.chips do total *= i
for i in o2.chips do total *= i

print "o1 * o2 * o3 = {total}".green
