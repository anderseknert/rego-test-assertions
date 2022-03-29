# METADATA
# description: Utility functions for working with Rego unit tests
# authors:
#   - Anders Eknert <anders@eknert.com>
#
package test.assert_test

import data.test.assert

# NOTE: These tests _should_ fail :)
# They are meant to demonstrate printing the assertion failures,
# which is hard to do without.. failures.

test_assert_equals {
	assert.equals(1, 1)
}

test_assert_equals_fail {
	assert.equals(1, 2)
}

test_assert_empty {
	assert.empty([])
	assert.empty({})
	assert.empty(set())
}

test_assert_empty_fail {
	assert.empty([1, 2, 3])
}
