# METADATA
# description: Utility functions for working with Rego unit tests
# authors:
#   - Anders Eknert <anders@eknert.com>
#
package test.assert_test

import rego.v1

import data.test.assert

test_assert_equals if {
	assert.equals(1, 1)
}

test_assert_equals_fail if {
	not assert.equals(1, 2)
}

test_assert_not_equals if {
	assert.not_equals(1, 2)
}

test_assert_not_equals_fail if {
	not assert.not_equals(1, 1)
}

test_assert_all_equals if {
	assert.all_equals([2, 2, 2], 2)
}

test_assert_all_equals_fail if {
	not assert.all_equals([1, 2, 2], 2)
}

test_assert_none_equals if {
	assert.none_equals([1, 3, 5], 2)
}

test_assert_none_equals_fail if {
	not assert.none_equals([1, 2, 2], 2)
}

test_assert_has if {
	assert.has(2, [1, 2, 3])
}

test_assert_has_fail if {
	not assert.has(4, [1, 2, 3])
}

test_assert_not_has if {
	assert.not_has(4, [1, 2, 3])
}

test_assert_not_has_fail if {
	not assert.not_has(2, [1, 2, 3])
}

test_assert_has_key if {
	assert.has_key("two", {"one": 1, "two": 2, "three": 3})
}

test_assert_has_key_fail if {
	not assert.has_key("four", {"one": 1, "two": 2, "three": 3})
}

test_assert_not_has_key if {
	assert.not_has_key("four", {"one": 1, "two": 2, "three": 3})
}

test_assert_not_has_key_fail if {
	not assert.not_has_key("two", {"one": 1, "two": 2, "three": 3})
}

test_assert_has_value if {
	assert.has_value(2, {"one": 1, "two": 2, "three": 3})
}

test_assert_has_value_fail if {
	not assert.has_value(4, {"one": 1, "two": 2, "three": 3})
}

test_assert_not_has_value if {
	assert.not_has_value(4, {"one": 1, "two": 2, "three": 3})
}

test_assert_not_has_value_fail if {
	not assert.not_has_value(2, {"one": 1, "two": 2, "three": 3})
}

test_assert_empty if {
	assert.empty([])
	assert.empty({})
	assert.empty(set())
}

test_assert_empty_fail if {
	not assert.empty([1, 2, 3])
}

test_assert_not_empty if {
	assert.not_empty([1])
	assert.not_empty({2})
}

test_assert_not_empty_fail if {
	not assert.not_empty([])
	not assert.not_empty({})
}

test_assert_starts_with if {
	assert.starts_with("alpha", "a")
}

test_assert_starts_with_fail if {
	not assert.starts_with("alpha", "l")
}

test_assert_ends_with if {
	assert.ends_with("alpha", "a")
}

test_assert_ends_with_fail if {
	not assert.ends_with("alpha", "l")
}

test_assert_all_starts_with if {
	assert.all_starts_with(["a", "abba", "alpha"], "a")
}

test_assert_all_startswith_fail if {
	not assert.all_starts_with(["a", "abba", "benny"], "a")
}

test_assert_none_starts_with if {
	assert.none_starts_with({"d", "b", "c"}, "a")
}

test_assert_none_startswith_fail if {
	not assert.none_starts_with({"a", "b", "c"}, "a")
}

test_assert_all_ends_with if {
	assert.all_ends_with(["a", "abba", "alpha"], "a")
}

test_assert_all_ends_with_fail if {
	not assert.all_ends_with(["a", "abba", "alpha"], "e")
}

test_assert_none_ends_with if {
	assert.none_ends_with({"d", "b", "c"}, "a")
}

test_assert_none_ends_with_fail if {
	not assert.none_ends_with({"d", "b", "c"}, "b")
}

test_fail if {
	not assert.fail("fail!")
}
