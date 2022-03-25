package rego.example_test

import future.keywords.in

import data.rego.assertions.assert_empty
import data.rego.assertions.assert_in

deny[msg] {
	msg := "I'll always deny that"
}

violation[msg] {
	input.user.name == "banned"
	msg := "You're banned!"
}

test_empty_without_assertion {
	count(deny) == 0
}

test_empty_with_assertion {
	assert_empty(deny)
}

test_in_without_assertion {
	"You're banned!" in violation with input.user.name as "bob"
}

test_in_with_assertion {
	assert_in("You're banned!", violation) with input.user.name as "bob"
}
