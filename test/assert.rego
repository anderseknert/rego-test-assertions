# METADATA
# description: Utility functions for working with Rego unit tests
# authors:
#   - Anders Eknert <anders@eknert.com>
#
package test.assert

import future.keywords

# METADATA
# description: Assert expected is equal to result
equals(expected, result) {
	expected == result
} else = false {
	print("expected equals:", _quote_if_string(expected), "got:", result)
}

# METADATA
# description: Assert expected is not equal to result
not_equals(expected, result) {
	expected != result
} else = false {
	print("expected not equals:", _quote_if_string(expected), "got:", result)
}

# METADATA
# description: Assert item is in coll
contains(item, coll) {
	item in coll
} else = false {
	print("expected", type_name(item), _quote_if_string(item), "in", type_name(coll), "got:", coll)
}

# METADATA
# description: Assert item is not in coll
not_contains(item, coll) {
	not item in coll
} else = false {
	print("expected", type_name(item), _quote_if_string(item), "not in", type_name(coll), "got:", coll)
}

# METADATA
# description: Assert provided collection is empty
empty(coll) {
	count(coll) == 0
} else = false {
	print("expected empty", type_name(coll), "got:", coll)
}

# METADATA
# description: Assert provided collection is not empty
not_empty(coll) {
	count(coll) != 0
} else = false {
	print("expected not empty", type_name(coll))
}

# METADATA
# description: Assert all strings in coll starts with search
all_startswith(coll, search) {
	every str in coll {
		startswith(str, search)
	}
} else = false {
	exceptions := [str | some str in coll; not startswith(str, search)]
	print("expected all strings to start with", concat("", [_quote_if_string(search), ","]), "failed for", exceptions)
}

# METADATA
# description: Assert no strings in coll starts with search
none_startswith(coll, search) {
	every str in coll {
		not startswith(str, search)
	}
} else = false {
	exceptions := [str | some str in coll; startswith(str, search)]
	print("expected no strings to start with", concat("", [_quote_if_string(search), ","]), "failed for", exceptions)
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
