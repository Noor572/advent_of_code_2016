redef class Array[E]
	fun remove_empty: Array[E] do
		if not self isa Array[String] then return self
		var ret = new Array[String]
		for i in self do if not i.trim.is_empty then ret.add i
		return ret
	end
end

fun check_triangle(dims: Array[String]): Bool do
	var s1 = dims[0].to_i
	var s2 = dims[1].to_i
	var s3 = dims[2].to_i
	if s1 + s2 <= s3 then return false
	if s1 + s3 <= s2 then return false
	if s2 + s3 <= s1 then return false
	return true
end

var input = args[0].to_path.read_all.split("\n")
var possible = 0
var total = 0
for i in input do
	if i == "" then break
	var dims = i.trim.split(" ").remove_empty
	total += 1
	if check_triangle(dims) then possible += 1
end
print "{possible}/{total}"
