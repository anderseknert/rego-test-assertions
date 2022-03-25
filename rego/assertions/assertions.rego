# METADATA
# description: Utility functions for working with Rego unit tests
# authors:
#   - Anders Eknert <anders@eknert.com>
#
package rego.assertions

import future.keywords.in

# METADATA
# description: Assert expected is equal to result, or fail while printing both inputs to console
assert_equals(expected, result) {
	expected == result
}

assert_equals(expected, result) = false {
	expected != result
	print("expected equals:", expected, "got:", result)
}

# METADATA
# description: Assert expected is not equal to result, or fail while printing both inputs to console
assert_not_equals(expected, result) {
	expected != result
}

assert_not_equals(expected, result) = false {
	expected == result
	print("expected not equals:", expected, "got:", result)
}

# METADATA
# description: Assert item is in coll, or fail while printing the collection to console
assert_in(item, coll) {
	item in coll
}

assert_in(item, coll) = false {
	not item in coll
	print("expected", type_name(item), _quote_if_string(item), "in", type_name(coll), "got", coll)
}

# METADATA
# description: Assert provided collection is empty, or fail while printing the collection to console
assert_empty(coll) {
    count(coll) == 0
}

assert_empty(coll) = false {
    count(coll) != 0
    print("expected empty", type_name(coll), "got", coll)
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
