# METADATA
# description: Utility functions for working with Rego unit tests
# authors:
#   - Anders Eknert <anders@eknert.com>
#
package test.assert

import future.keywords

# METADATA
# description: Assert expected is equal to result, or fail while printing both inputs to console
equals(expected, result) {
	expected == result
}

equals(expected, result) = false {
	expected != result
	print("expected equals:", _quote_if_string(expected), "got:", result)
}

# METADATA
# description: Assert expected is not equal to result, or fail while printing both inputs to console
not_equals(expected, result) {
	expected != result
}

not_equals(expected, result) = false {
	expected == result
	print("expected not equals:", _quote_if_string(expected), "got:", result)
}

# METADATA
# description: Assert item is in coll, or fail while printing the collection to console
contains(item, coll) {
	item in coll
}

contains(item, coll) = false {
	not item in coll
	print("expected", type_name(item), _quote_if_string(item), "in", type_name(coll), "got:", coll)
}

# METADATA
# description: Assert item is not in coll, or fail while printing the collection to console
not_contains(item, coll) {
	not item in coll
}

not_contains(item, coll) = false {
	item in coll
	print("expected", type_name(item), _quote_if_string(item), "not in", type_name(coll), "got:", coll)
}

# METADATA
# description: Assert provided collection is empty, or fail while printing the collection to console
empty(coll) {
	count(coll) == 0
}

empty(coll) = false {
	count(coll) != 0
	print("expected empty", type_name(coll), "got:", coll)
}

# METADATA
# description: Fail with provided message
fail(msg) {
	print(msg)
	false
}

_quote_if_string(x) = concat("", [`"`, x, `"`]) {
	is_string(x)
}

_quote_if_string(x) = x {
	not is_string(x)
}

# Since we want a function named "in", we're prohibited from using the built-in
#_member_of(item, coll) {

#}