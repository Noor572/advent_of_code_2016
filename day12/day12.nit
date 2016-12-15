import visit
import machine

var machine = build_machine(args[0])
if machine == null then return

# Part 1
print machine.state
machine.execute
print machine.state

# Part 2
machine.reset
machine.regs[machine.regs_ids.index_of('c')] = 1

print machine.state
machine.execute
print machine.state
