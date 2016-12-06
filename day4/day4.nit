import counter
import crypto
import for_abuse

redef class Counter[E]
	fun pack: Array[Array[E]] do
		var ret = new Array[Array[E]]
		var base = self.sort.reversed
		if base.is_empty then return ret
		var curr = new Array[E]
		curr.push base.first
		var curr_score = self[base.first]
		base.shift
		for i in base do
			if self[i] == curr_score then
				curr.push i
				continue
			end
			curr_score = self[i]
			ret.push curr
			curr = new Array[E]
			curr.push i
		end
		if not curr.is_empty then ret.push curr
		return ret
	end
end

class Room
	var enc_name: String
	var id: Int
	var checksum: String

	init from_format(format: String) do
		var form_lbra = format.split('[')
		var checksum = form_lbra[1].split(']').first
		var id = form_lbra.first.split('-').last.to_i
		var name = form_lbra.first.split('-')
		name.pop
		var enc_name = name.join("-")
		init(enc_name, id, checksum)
	end

	fun count_frequency: Counter[Char] do
		var ret = new Counter[Char]
		for i in enc_name do
			if i == '-' then continue
			ret.inc(i)
		end
		return ret
	end

	fun pick_five(in_arr: Array[Array[Char]]): Array[Char] do
		var ret = new Array[Char]
		var tot = 0
		for i in in_arr do
			for k in i.sort_fa do k.res = k.a <=> k.b
			for j in i do
				ret.add j
				tot += 1
				if tot == 5 then return ret
			end
			if tot == 5 then return ret
		end
		return ret
	end

	fun is_valid: Bool do
		var cnt = count_frequency
		var tmp = cnt.pack
		var srt = pick_five(tmp)
		for i in checksum, j in [0 .. checksum.length[ do
			if srt[j] == i then continue
			return false
		end
		return true
	end

	redef fun to_s do return "\n-\tenc_name: `{enc_name}`\n-\tid: `{id}`\n-\tchecksum: `{checksum}`\n"
end

fun uncrypt(room: Room): Text do
	var ret = room.enc_name.rot(room.id)
	ret.split("-").join(" ")
	return ret
end

var input = args[0].to_path.read_all.split('\n')
var total = 0
var valid_rooms = new Array[Room]
for i in input do
	if i == "" then continue
	var r = new Room.from_format(i.trim)
	if not r.is_valid then continue
	valid_rooms.push r
	total += r.id
end
for i in valid_rooms do
	var ret = uncrypt(i)
	if ret == "northpole-object-storage" then print "Room {ret} is number {i.id}"
end
print total
