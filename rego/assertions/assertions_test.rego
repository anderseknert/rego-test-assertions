# METADATA
# description: Utility functions for working with Rego unit tests
# authors:
#   - Anders Eknert <anders@eknert.com>
#
package rego.assertions_test

import data.rego.assertions.assert_empty
import data.rego.assertions.assert_equals

# NOTE: These tests _should_ fail :)
# They are meant to demonstrate printing the assertion failures,
# which is hard to do without.. failures.

test_assert_equals {
	assert_equals(1, 1)
}

test_assert_equals_fail {
	assert_equals(1, 2)
}

test_assert_empty {
	assert_empty([])
	assert_empty({})
	assert_empty(set())
}

test_assert_empty_fail {
	assert_empty([1, 2, 3])
}
