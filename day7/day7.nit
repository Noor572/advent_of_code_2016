redef class Text
	fun support_tls: Bool do
		var ignore_depth = 0
		var c4 = 0
		for i in self, j in [0 .. length[ do
			if i == '[' then
				ignore_depth += 1
			end
			if i == ']' then
				ignore_depth -= 1
			end
			if ignore_depth != 0 then continue
			if check_4(j) then c4 += 1
		end
		return c4 == 1
	end

	fun check_4(pos: Int): Bool do
		if pos + 4 >= length then return false
		var first = self[pos]
		var sec = self[pos + 1]
		var third = self[pos + 2]
		var last = self[pos + 3]
		if first != last then return false
		if sec != third then return false
		if first == sec then return false
		return true
	end

	fun support_ssl: Bool do
		var depth = 0
		var abas = new Array[Text]
		var babs = new Array[Text]
		for i in self, j in [0 .. length[ do
			if i == '[' then
				depth += 1
				continue
			end
			if i == ']' then
				depth -= 1
				continue
			end
			if depth > 0 then
				if check_3(j) then babs.push(substring(j, 3))
				continue
			end
			if check_3(j) then abas.push(substring(j, 3))
		end
		return check_babs(babs, abas)
	end

	fun check_babs(babs, abas: Array[Text]): Bool do
		var ssl = 0
		for i in abas do
			for k in babs do
				if k.is_bab(i) then ssl += 1
			end
		end
		return ssl >= 1
	end

	fun is_bab(bab: Text): Bool do return first == bab[1] and bab.first == self[1]

	fun check_3(pos: Int): Bool do
		if pos + 2 >= length then return false
		var fst = self[pos]
		var sec = self[pos + 1]
		var trd = self[pos + 2]
		if fst == ']' or sec == ']' or trd == ']' then return false
		if fst == '[' or sec == '[' or trd == '[' then return false
		return fst == trd and fst != sec
	end
end

var input = args[0].to_path.read_all.split('\n')

var supporting = 0
var ssl_support = 0

for i in input do
	if i.support_tls then supporting += 1
	if i.support_ssl then ssl_support += 1
end

print "TLS support: {supporting}"
print "SSL support: {ssl_support}"
