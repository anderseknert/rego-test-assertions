# METADATA
# description: Utility functions for working with Rego unit tests
# authors:
#   - Anders Eknert <anders@eknert.com>
#
package test.assert

import future.keywords.every
import future.keywords.if
import future.keywords.in

# METADATA
# description: Assert expected is equal to result
equals(expected, result) if {
	expected == result
} else := false if {
	print("expected equals:", _quote_str(expected), "got:", result)
}

# METADATA
# description: Assert expected is not equal to result
not_equals(expected, result) if {
	expected != result
} else := false if {
	print("expected not equals:", _quote_str(expected), "got:", result)
}

# METADATA
# description: Assert all items in coll are equal to value
all_equals(coll, value) if {
	every item in coll {
		item == value
	}
} else := false if {
	exceptions := [item | some item in coll; item != value]
	print("expected all items to have value", _append_comma(value), "failed for", exceptions)
}

# METADATA
# description: Assert no items in coll are equal to value
none_equals(coll, value) if {
	every item in coll {
		item != value
	}
} else := false if {
	exceptions := [item | some item in coll; item == value]
	print("expected no items to have value", _append_comma(value), "failed for", exceptions)
}

# METADATA
# description: Assert item is in coll
has(item, coll) if {
	item in coll
} else := false if {
	print("expected", type_name(item), _quote_str(item), "in", type_name(coll), "got:", coll)
}

# METADATA
# description: Assert item is not in coll
not_has(item, coll) if {
	not item in coll
} else := false if {
	print("expected", type_name(item), _quote_str(item), "not in", type_name(coll), "got:", coll)
}

# METADATA
# description: Assert provided collection is empty
empty(coll) if {
	count(coll) == 0
} else := false if {
	print("expected empty", type_name(coll), "got:", coll)
}

# METADATA
# description: Assert provided collection is not empty
not_empty(coll) if {
	count(coll) != 0
} else := false if {
	print("expected not empty", type_name(coll))
}

# METADATA
# description: Assert string starts with search
starts_with(str, search) if {
	startswith(str, search)
} else := false if {
	print("expected", _quote_str(str), "to start with", _quote_str(search))
}

# METADATA
# description: Assert string ends with search
ends_with(str, search) if {
	endswith(str, search)
} else := false if {
	print("expected", _quote_str(str), "to end with", _quote_str(search))
}

# METADATA
# description: Assert all strings in coll starts with search
all_starts_with(coll, search) if {
	every str in coll {
		startswith(str, search)
	}
} else := false if {
	exceptions := [str | some str in coll; not startswith(str, search)]
	print("expected all strings to start with", _append_comma(search), "failed for", exceptions)
}

# METADATA
# description: Assert all strings in coll ends with search
all_ends_with(coll, search) if {
	every str in coll {
		endswith(str, search)
	}
} else := false if {
	exceptions := [str | some str in coll; not endswith(str, search)]
	print("expected all strings to end with", _append_comma(search), "failed for", exceptions)
}

# METADATA
# description: Assert no strings in coll starts with search
none_starts_with(coll, search) if {
	every str in coll {
		not startswith(str, search)
	}
} else := false if {
	exceptions := [str | some str in coll; startswith(str, search)]
	print("expected no strings to start with", _append_comma(search), "failed for", exceptions)
}

# METADATA
# description: Assert no strings in coll ends with search
none_ends_with(coll, search) if {
	every str in coll {
		not endswith(str, search)
	}
} else := false if {
	exceptions := [str | some str in coll; endswith(str, search)]
	print("expected no strings to end with", _append_comma(search), "failed for", exceptions)
}

# METADATA
# description: Fail with provided message
fail(msg) if {
	print(msg)

	# regal ignore:constant-condition
	false
}

_quote_str(x) := concat("", [`"`, x, `"`]) if is_string(x)

_quote_str(x) := x if not is_string(x)

_append_comma(str) := sprintf("%v,", [_quote_str(str)])
